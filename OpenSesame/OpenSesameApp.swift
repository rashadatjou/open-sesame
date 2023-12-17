// OpenSesameApp.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 29/11/2023

import SwiftUI
import SettingsAccess

@main
struct OpenSesameApp: App {
  var body: some Scene {
    MenuBarExtra(
      "Open Sesame",
      systemImage: "door.french.open"
    ) {
      ContentView()
        .openSettingsAccess()
    }
    .menuBarExtraStyle(.window)

    Settings {
      SettingsView()
    }
  }
}
