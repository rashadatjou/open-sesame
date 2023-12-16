// PortView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Sesame
import SwiftUI

struct PortView: View {
  @StateObject
  private var model = PortModel()

  @StateObject
  private var settings = SettingModel.shared

  @Environment(\.openSettings)
  private var openSettings

  var body: some View {
    VStack {
      NavigationStack {
        List(model.openPortList, id: \.port) { port in
          NavigationLink(value: port) {
            PortItemView(icon: "network", port: port)
          }
          .listRowSeparator(.hidden)
        }
        .navigationDestination(for: Sesame.Port.self) { port in
          PortDetailView(port: port)
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
      model.listen(interval: 10)
    }
  }
}
