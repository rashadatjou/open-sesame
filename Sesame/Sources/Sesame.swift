// The Swift Programming Language
// https://docs.swift.org/swift-book

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
    // TODO: Throw error 
    print("Error parsing output")
    return nil
  }

  let app = try JSONDecoder().decode(App.self, from: data)

  return app
}
