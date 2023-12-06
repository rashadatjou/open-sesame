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
    let portList = try Sesame.loadPorts()
    let onlyPortList = portList.map(\.port)
    let onlyPortSet = Set(onlyPortList)

    let hasDuplicates = onlyPortSet.count != onlyPortList.count
    XCTAssertFalse(hasDuplicates, "Port list contains duplicate ports")
  }
}
