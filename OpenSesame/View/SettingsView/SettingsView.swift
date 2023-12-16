// SettingsView.swift
// OpenSesame by @rashadatjou
// macOS(14.2) with Swift(5.0)
// 16/12/2023

import SwiftUI

struct SettingsView: View {
  @AppStorage("showPreview")
  private var showPreview = true

  @AppStorage("fontSize")
  private var fontSize = 12.0

  var body: some View {
    Form {
      Toggle("Show Previews", isOn: $showPreview)
      Slider(value: $fontSize, in: 9 ... 96) {
        Text("Font Size (\(fontSize, specifier: "%.0f") pts)")
      }
    }
    .padding(20)
    .frame(width: 350, height: 100)
  }
}

#Preview {
  SettingsView()
}
