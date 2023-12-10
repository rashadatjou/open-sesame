// PortDetailView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Sesame
import SwiftUI

// HStack {
//  Button("Open Localy") {
//    print("Open in browser")
//  }
//  Button("Copy Info") {
//    print(app.rawJSON)
//  }
//  Button("Kill App") {
//    print("Copy info")
//  }
// }

struct ActionView: View {
  var app: Sesame.App

  var body: some View {
    List {
      DetailTextView(
        detailText: "Name",
        mainText: app.name
      )
      DetailTextView(
        detailText: "Bundle ID",
        mainText: app.bundleID
      )
      DetailTextView(
        detailText: "Bundle Path",
        mainText: app.path
      )
      DetailTextView(
        detailText: "Executable Path",
        mainText: app.executablePath
      )
      DetailTextView(
        detailText: "ASN ID",
        mainText: app.asn
      )
      DetailTextView(
        detailText: "Creator",
        mainText: app.creator
      )
      DetailTextView(
        detailText: "PID",
        mainText: app.pid
      )
      DetailTextView(
        detailText: "Architecture",
        mainText: app.arch
      )
      DetailTextView(
        detailText: "Type",
        mainText: app.type
      )
      DetailTextView(
        detailText: "Version",
        mainText: app.version
      )
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
    return "Port " + String(port.port)
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
