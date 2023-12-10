// Koopa.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 06/12/2023

import ShellKit

final class Koopa {
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
  func execute() throws -> String {
    let formatedCommand = commandList.joined(separator: " | ")
    commandList = []
    return try shell.run(formatedCommand)
  }

  @discardableResult
  public func run(_ command: String) throws -> String {
    return try shell.run(command)
  }
}
