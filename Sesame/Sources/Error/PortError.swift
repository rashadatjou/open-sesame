// PortError.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 04/12/2023

import Foundation

public enum PortError: Swift.Error {
  case shellNotFound
  case failedToLoad
}
