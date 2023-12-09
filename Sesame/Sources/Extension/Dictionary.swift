// File.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Foundation

extension Dictionary where Key == String, Value == Any {
  func toJSON(options: JSONSerialization.WritingOptions = []) throws -> String? {
    let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
    return String(data: jsonData, encoding: .utf8)
  }
}
