// SettingModel.swift
// OpenSesame by @rashadatjou
// macOS(14.2) with Swift(5.0)
// 16/12/2023

import LaunchAtLogin
import SwiftUI

class SettingModel: ObservableObject {
  // - Type Props
  static let shared = SettingModel()

  static let refreshIntervalList: [TimeInterval] = [
    1,
    2,
    5,
    10,
    15,
    20,
    30,
    60,
    120,
    180,
    240,
    300,
    600,
    900,
    1800,
    3600
  ]

  // - Lifecycle
  private init() {}

  // - Computed
  var excludedPortList: [Int] {
    let clean = excludePortText
      .split(separator: ",")
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      .compactMap { Int($0) }

    return clean
  }

  var launchAtLoginEnabled: Bool {
    LaunchAtLogin.isEnabled
  }

  // - State
  @AppStorage(SettingKeys.only4DigitPorts.rawValue)
  private(set) var hidePortsAbove4Digits: Bool = false {
    didSet {
      objectWillChange.send()
    }
  }

  @AppStorage(SettingKeys.excludePortText.rawValue)
  private(set) var excludePortText: String = "" {
    didSet {
      objectWillChange.send()
    }
  }

  @AppStorage(SettingKeys.refreshInterval.rawValue)
  private(set) var refreshInterval: TimeInterval = 5 {
    didSet {
      objectWillChange.send()
    }
  }
}
