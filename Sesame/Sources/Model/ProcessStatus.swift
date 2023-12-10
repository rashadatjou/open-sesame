// ProcessStatus.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 10/12/2023

import Foundation

public struct ProcessStatus: Codable {
  public let pid: Int
  public let ppid: Int
  public let user: String
  public let command: String
  
  public var rawJSON: String? {
    do {
      let encoder = JSONEncoder()
      let data = try encoder.encode(self)
      return String(data: data, encoding: .utf8)
    } catch {
      return nil
    }
  }
}
