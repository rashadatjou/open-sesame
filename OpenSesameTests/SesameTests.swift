// SesameTests.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 30/11/2023

@testable import Sesame
import XCTest

final class SesameTests: XCTestCase {
  // Use the CLI to get a list of ports
  func testLoadAllPorts() throws {
    let list = try Sesame.loadPorts()

    XCTAssertNotEqual(list, [], "List of should not be empty.")
  }

  func testLoadNoDuplicatePorts() throws {
    // TODO: Validate that there are no duplicates
  }
}
