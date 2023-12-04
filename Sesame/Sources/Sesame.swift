// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import ShellKit

// - Stored Props
private var shell: Shell = {
  let type = "/bin/bash"
  let env = ["": ""]
  return Shell(type, env: env)
}()

// - Public API
func loadPorts() throws -> [Port] {
  let shellOutput = try shell.run(#"netstat -Watnlv | grep LISTEN | awk '{ split($4, a, /[.*:]/); port = a[length(a)]; if (port ~ /^[0-9]+$/) { "ps -o comm= -p " $9 | getline procname; print "{ \"proto\": \"" $1 "\", \"port\": \"" port "\", \"pid\": \"" $9 "\", \"name\": \"" procname "\" }"; } }'"#)

  let outputList = shellOutput.components(separatedBy: .newlines)
  var portList: [Port] = []

  for output in outputList {
    guard let data = output.data(using: .utf8) else { continue }
    let port = try JSONDecoder().decode(Port.self, from: data)
    portList.append(port)
  }

  return portList
}
