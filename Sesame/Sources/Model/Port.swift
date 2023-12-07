// Port.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 03/12/2023

import Foundation

public struct Port: Equatable, Decodable, Hashable {
  public let name: String
  public let pid: Int
  public let port: Int
  public let `protocol`: String

  enum CodingKeys: CodingKey {
    case name
    case pid
    case port
    case `protocol`
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.protocol = try container.decode(String.self, forKey: .protocol)

    let stringPort = try container.decode(String.self, forKey: .port)
    self.port = Int(stringPort) ?? -1

    let stringPid = try container.decode(String.self, forKey: .pid)
    self.pid = Int(stringPid) ?? -1
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.port == rhs.port
  }
}
