// PortView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Combine
import Sesame
import SwiftUI

struct PortView: View {
  @StateObject
  private var model = PortModel()

  @StateObject
  private var settings = SettingModel.shared

  @Environment(\.openSettings)
  private var openSettings

  // - Props
  private var dataSource: [Sesame.Port] {
    var list = model.openPortList

    if settings.hidePortsAbove4Digits {
      list.removeAll(where: { $0.port > 9999 })
    }

    if !settings.excludePortText.isEmpty {
      list.removeAll(where:
        { settings.excludedPortList.contains($0.port) }
      )
    }

    return list
  }

  // - Body
  var body: some View {
    NavigationStack {
      VStack(alignment: .center) {
        if dataSource.isEmpty {
          Spacer()

          Text("Sesame is closed.")
            .font(.title)
            .fontWeight(.semibold)
            .padding()

        } else {
          List(dataSource, id: \.port) { port in
            NavigationLink(value: port) {
              PortItemView(icon: "network", port: port)
                .shadow(color: .gray, radius: 2)
            }
            .listRowSeparator(.hidden)
          }
          .navigationDestination(for: Sesame.Port.self) { port in
            PortDetailView(port: port)
          }
        }

        Spacer()

        VStack {
          PlainItemView(
            title: "Settings",
            shortcut: "⌘ ,",
            action: {
              try? openSettings()
            }
          )
          PlainItemView(
            title: "Quit",
            shortcut: "⌘Q",
            action: {
              exit(0)
            }
          )
        }
        .padding([.bottom, .horizontal], 6)
      }
    }
    .frame(width: 260, height: 300)
    .onAppear {
      model.load()
      model.listen(interval: settings.refreshInterval)
    }
    .onChange(of: settings.refreshInterval, perform: { value in
      model.abortListening()
      model.listen(interval: value)
    })
  }
}
