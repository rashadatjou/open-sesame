// File.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 10/12/2023

import Foundation

public struct Command: Codable {
  public let pid: String
  public let ppid: String
  public let user: String
  public let command: String
}
