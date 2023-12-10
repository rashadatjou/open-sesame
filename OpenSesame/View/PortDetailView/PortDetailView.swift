// PortDetailView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import AppKit
import Sesame
import SwiftUI

struct QuickActions: View {
  // - Props
  var rawData: String?
  var port: Sesame.Port

  // - Environment
  @Environment(\.openURL)
  var openURL

  var body: some View {
    HStack {
      Button("Open URL") {
        guard let url = URL(string: "http://localhost:\(port.port)") else {
          // TODO: Show warning
          return
        }

        openURL(url)
      }
      Button("Copy All") {
        guard let json = rawData else {
          // TODO: Show warning
          return
        }

        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(json, forType: .string)
      }
    }
    .padding(.bottom, 8)
  }
}

struct ProcessStatusDataList: View {
  // - Props
  var processStatus: Sesame.ProcessStatus

  var body: some View {
    List {
      CopiableTextView(
        detailText: "User",
        mainText: processStatus.user
      )
      CopiableTextView(
        detailText: "Path",
        mainText: processStatus.command
      )

      CopiableTextView(
        detailText: "PID",
        mainText: String(processStatus.pid)
      )

      CopiableTextView(
        detailText: "PPID",
        mainText: String(processStatus.ppid)
      )
    }
  }
}

struct AppDataList: View {
  var app: Sesame.App

  var body: some View {
    List {
      CopiableTextView(
        detailText: "Name",
        mainText: app.name
      )
      CopiableTextView(
        detailText: "Bundle ID",
        mainText: app.bundleID
      )
      CopiableTextView(
        detailText: "Bundle Path",
        mainText: app.path
      )
      CopiableTextView(
        detailText: "Executable Path",
        mainText: app.executablePath
      )
      CopiableTextView(
        detailText: "ASN ID",
        mainText: app.asn
      )
      CopiableTextView(
        detailText: "Creator",
        mainText: app.creator
      )
      CopiableTextView(
        detailText: "PID",
        mainText: app.pid
      )
      CopiableTextView(
        detailText: "Architecture",
        mainText: app.arch
      )
      CopiableTextView(
        detailText: "Type",
        mainText: app.type
      )
      CopiableTextView(
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

  @State
  private var processStatus: Sesame.ProcessStatus?

  var body: some View {
    VStack {
      if app == nil && processStatus == nil {
        ProgressView("Looking...")
      }

      if let app {
        AppDataList(app: app)
        QuickActions(rawData: app.rawJSON, port: port)
      }

      if let processStatus {
        ProcessStatusDataList(processStatus: processStatus)
        QuickActions(rawData: processStatus.rawJSON, port: port)
      }
    }
    .navigationTitle(navigationTitle)
    .task(priority: .high, loadInfo)
    .frame(maxHeight: .infinity)
  }

  // - Property Modifiers
  private var navigationTitle: String {
    return "Port " + String(port.port)
  }

  // - Actions
  @Sendable
  private func loadInfo() {
    do {
      app = try Sesame.loadApp(for: port)
    } catch {
      Swift.print("Error while loading app.", error)
    }

    guard app == nil else { return } // if app has failed

    do {
      processStatus = try Sesame.loadProcessStatus(for: port)
    } catch {
      Swift.print("Error while process status.", error)
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
