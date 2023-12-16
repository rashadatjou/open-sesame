// SettingModel.swift
// OpenSesame by @rashadatjou
// macOS(14.2) with Swift(5.0)
// 16/12/2023

import SwiftUI

class SettingModel: ObservableObject {
  // - Instance Props
  static let shared = SettingModel()

  // - Lifecycle
  private init() {}

  // - State
  @AppStorage(SettingKeys.only4DigitPorts.rawValue)
  private(set) var hidePortsAbove4Digits: Bool = false {
    didSet {
      objectWillChange.send()
    }
  }
}
