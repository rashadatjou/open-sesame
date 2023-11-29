//
//  OpenSesameApp.swift
//  OpenSesame
//
//  Created by Wolf on 29/11/2023.
//

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
