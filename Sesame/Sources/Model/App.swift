// App.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Foundation

public struct App: Decodable {
  public let name: String
  public let path: String
  public let executablePath: String
  public let bundleID: String
  public let asn: String
  public let pid: String
  public let type: String
  public let version: String
  public let creator: String
  public let arch: String

  enum CodingKeys: String, CodingKey {
    case name
    case asn
    case pid
    case version
    case arch
    case path = "bundlepath"
    case executablePath = "executablepath"
    case bundleID = "bundleid"
    case type = "applicationtype"
    case creator = "filecreator"
  }
}
