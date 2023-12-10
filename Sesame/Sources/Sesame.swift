// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppKit
import Foundation

// - Types
public typealias PortCallback = (Swift.Result<[Port], PortError>) -> Void
public typealias EmptyFunction = () -> Void

// - Stored Props
private var shell: Koopa = {
  let type = "/bin/bash"
  let env = ["": ""]
  return Koopa(type: type, env: env)
}()

// - Public API
public func loadPorts() throws -> [Port] {
  let shellOutput = try shell
    .pipe("netstat -Watnlv")
    .pipe("grep LISTEN")
    .pipe(#"awk '{ split($4, a, /[.*:]/); port = a[length(a)]; if (port ~ /^[0-9]+$/) { "ps -o comm= -p " $9 | getline procname; print "{ \"protocol\": \"" $1 "\", \"port\": \"" port "\", \"pid\": \"" $9 "\" }"; } }'"#)
    .execute()

  let outputList = shellOutput.components(separatedBy: .newlines)
  var portList: [Port] = []

  for output in outputList {
    guard let data = output.data(using: .utf8) else { continue }
    let port = try JSONDecoder().decode(Port.self, from: data)
    portList.append(port)
  }

  return portList.removingDuplicates(basedOn: \.port)
}

@discardableResult
public func listenForPorts(
  every interval: TimeInterval,
  _ completion: @escaping PortCallback
) -> EmptyFunction {
  let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
    do {
      let portList = try loadPorts()
      completion(.success(portList))
    } catch let error as PortError {
      completion(.failure(error))
    } catch {
      completion(.failure(.failedToLoad))
    }
  }

  return {
    timer.invalidate()
  }
}

public func loadApp(for port: Port) throws -> App? {
  let lsappinfoKeys = [
    "name",
    "asn",
    "bundleid",
    "bundlepath",
    "executablepath",
    "applicationtype",
    "version",
    "filecreator",
    "arch",
    "pid"
  ]

  let rawDicionary = try lsappinfoKeys.reduce(into: [String: Any]()) { result, key in
    let value = try shell
      .pipe("lsappinfo info -only \(key) \(port.pid)")
      .pipe(#"awk -F'=' '{gsub(/"/, "", $2); print $2}'"#)
      .execute()
    return result[key] = value
  }

  guard let rawJSON = try rawDicionary.toJSON(),
        let data = rawJSON.data(using: .utf8)
  else {
    throw AppError.invalidAppInfo
  }

  let app = try JSONDecoder().decode(App.self, from: data)

  if app.name.contains("[ NULL ]") {
    throw AppError.emptyApp
  }

  return app
}

public func loadProcessStatus(for port: Port) throws -> ProcessStatus? {
  let rawOutput = try shell
    .pipe("ps -p \(port.pid) -o pid=,ppid=,user=,args=")
    .pipe(#"awk '{print "{\"pid\": "$1", \"ppid\": "$2", \"user\": \""$3"\", \"command\": \""$4"\"}"}'"#)
    .execute()

  guard let data = rawOutput.data(using: .utf8) else {
    // TODO: Throw error
    return nil
  }

  let decoder = JSONDecoder()
  let processStatus = try decoder.decode(ProcessStatus.self, from: data)

  return processStatus
}

public func loadRunningApplication(for port: Port) -> App? {
  guard let runningApp = NSRunningApplication(processIdentifier: pid_t(port.pid)) else {
    // TODO: Throw error
    return nil
  }

  guard let localizedName = runningApp.localizedName,
        let path = runningApp.bundleURL?.absoluteString
  else {
    // TODO: Throw error
    return nil
  }

  let app = App(
    name: localizedName,
    path: path,
    executablePath: runningApp.executableURL?.absoluteString ?? "",
    bundleID: runningApp.bundleIdentifier ?? "",
    asn: "",
    pid: String(port.pid),
    type: "",
    version: "",
    creator: "",
    arch: ""
  )

  return app
}

func isAppSandboxed() -> Bool {
  let homeDirectory = NSHomeDirectory()
  return homeDirectory.contains("/Library/Containers/")
}
