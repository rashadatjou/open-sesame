// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

// - Stored Props
private var shell: Koopa = {
  let type = "/bin/bash"
  let env = ["": ""]
  return Koopa(type: type, env: env)
}()

// - Public API
func loadPorts() throws -> [Port] {
  let shellOutput = try shell
    .pipe("netstat -Watnlv")
    .pipe("grep LISTEN")
    .pipe(#"awk '{ split($4, a, /[.*:]/); port = a[length(a)]; if (port ~ /^[0-9]+$/) { "ps -o comm= -p " $9 | getline procname; print "{ \"protocol\": \"" $1 "\", \"port\": \"" port "\", \"pid\": \"" $9 "\", \"name\": \"" procname "\" }"; } }'"#)
    .run()

  let outputList = shellOutput.components(separatedBy: .newlines)
  var portList: [Port] = []

  for output in outputList {
    guard let data = output.data(using: .utf8) else { continue }
    let port = try JSONDecoder().decode(Port.self, from: data)
    portList.append(port)
  }

  return portList
}
