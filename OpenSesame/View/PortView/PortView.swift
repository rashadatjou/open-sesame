// PortView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Sesame
import SwiftUI

struct PortView: View {
  @StateObject
  private var model = PortModel()

  var body: some View {
    VStack {
      List(model.openPortList, id: \.port) { port in
        PortItemView(icon: "network", port: port)
      }
      VStack {
        PlainItemView(
          title: "Settings",
          shortcut: "⌘ ,"
        )
        PlainItemView(
          title: "Quit",
          shortcut: "⌘Q"
        )
      }
      .padding([.bottom, .horizontal], 6)
    }
    .frame(width: 260, height: 300)
    .onAppear {
      do {
        try model.load()
      } catch {
        print("Loading of the model failed")
      }
    }
  }
}
