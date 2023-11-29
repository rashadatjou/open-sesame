// OpenSesameApp.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 29/11/2023

import SwiftUI

@main
struct OpenSesameApp: App {
  var body: some Scene {
    MenuBarExtra(
      "Utility App",
      systemImage: "hammer"
    ) {
      ContentView()
    }
    .menuBarExtraStyle(.window)
  }
}
