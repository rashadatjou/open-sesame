// File.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 06/12/2023

import ShellKit

public final class Koopa {
  // - Props
  let type: String
  let env: [String: String]
  private(set) var commandList: [String] = []

  // - Service
  private lazy var shell: Shell = .init(type, env: env)

  // - Init
  init(type: String? = nil, env: [String: String]? = nil) {
    self.type = type ?? "/bin/sh"
    self.env = env ?? [:]
  }
}

// MARK: - API

extension Koopa {
  func pipe(_ command: String) -> Self {
    commandList.append(command)
    return self
  }

  func print() -> Self {
    Swift.print(commandList.joined(separator: " | "))
    return self
  }

  @discardableResult
  func run() throws -> String {
    let formatedCommand = commandList.joined(separator: " | ")
    return try shell.run(formatedCommand)
  }
}
