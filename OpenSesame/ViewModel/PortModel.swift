// PortModel.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 07/12/2023

import Sesame
import SwiftUI

@MainActor
class PortModel: ObservableObject {
  // - Public Props
  @Published
  private(set) var openPortList: [Sesame.Port] = []

  // - Private Props
  private var portCancel: Sesame.EmptyFunction?
}

// MARK: - API

extension PortModel {
  func load() {
    do {
      let loadedListOfPorts = try Sesame.loadPorts()
      openPortList = loadedListOfPorts
    } catch {
      // TODO: Send error upstream
      print("loadingPortsFailed:", error)
    }
  }

  func listen(interval: TimeInterval) {
    portCancel = Sesame.listenForPorts(every: interval) { result in
      switch result {
      case .success(let loadedPortList):
        self.openPortList = loadedPortList
      case .failure(let error):
        // TODO: Send error upstream
        print("listeningPortsFailed:", error)
      }
    }
  }

  func abortListening() {
    portCancel?()
    openPortList = []
  }
}
