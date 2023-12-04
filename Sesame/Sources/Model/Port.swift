// Port.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 03/12/2023

import Foundation

struct Port: Equatable, Decodable {
  let name: String
  let pid: String
  let port: String
  let proto: String
}
