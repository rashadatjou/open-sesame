// PortDetailView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Sesame
import SwiftUI

struct ActionView: View {
  var app: Sesame.App

  var body: some View {
    VStack {
      Text("Add actions here")
    }
  }
}

struct PortDetailView: View {
  // - Props
  var port: Sesame.Port

  // - State
  @State
  private var app: Sesame.App?

  var body: some View {
    VStack {
      if let app {
        ActionView(app: app)
      } else {
        ProgressView()
      }
    }
    .navigationTitle(navigationTitle)
    .task(priority: .high, loadApp)
    .frame(maxHeight: .infinity)
  }

  // - Property Modifiers
  private var navigationTitle: String {
    if let app {
      return app.name
    } else {
      return "Finding app..."
    }
  }

  // - Actions
  @Sendable
  private func loadApp() {
    do {
      app = try Sesame.loadApp(for: port)
    } catch {
      Swift.print("Error while loading app.", error)
    }
  }
}

#Preview {
  let randomPort = try? Sesame.loadPorts().first(
    where: { $0.port < 9999 }
  )

  return PortDetailView(port: randomPort!)
    .frame(width: 300, height: 300)
}
