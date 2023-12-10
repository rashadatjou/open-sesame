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

  func testListeningForPorts() throws {
    let interval: TimeInterval = 2
    let callbackMax = 5
    let intervalMax = interval * TimeInterval(callbackMax)
    let expectation = self.expectation(description: "listeningForPortsTest")
    var callbackCounter = 0
    var portCounter = 0

    let listener = Sesame.listenForPorts(every: interval) { result in

      switch result {
      case .success(let ports):
        callbackCounter += 1
        portCounter += ports.count
        if callbackCounter == callbackMax {
          expectation.fulfill()
        }
      case .failure(let error):
        XCTFail("The port listenere has failed with an error: \(error.localizedDescription)")
      }
    }

    // Wait for the expectations to be fulfilled or timeout
    wait(for: [expectation], timeout: intervalMax + 0.1)

    // Cancle listener
    listener()

    // Assert the callback was called 5 times
    XCTAssertNotEqual(portCounter, 0, "The number of ports listned for was bigger than 0")
  }

  func testLoadApp() throws {
    let port = try Sesame.loadPorts().first(where: { $0.port < 9999 })

    let cleanPort = try XCTUnwrap(port)

    let app = try Sesame.loadApp(for: cleanPort)

    XCTAssertNotNil(app, "App for pid: \(cleanPort.pid) is nil")
  }

  func testLoadingOfProcessStatus() throws {
    let port = try Sesame.loadPorts().first(where: { $0.port < 9999 })

    let cleanPort = try XCTUnwrap(port)

    let ps = try Sesame.loadProcessStatus(for: cleanPort)

    XCTAssertNotNil(ps, "ProcessStatus for pid: \(cleanPort.pid) is nil")
  }
}
