// SettingsView.swift
// OpenSesame by @rashadatjou
// macOS(14.2) with Swift(5.0)
// 16/12/2023

import SwiftUI

struct SettingsView: View {
 
  @StateObject
  private var model = SettingModel.shared

  var body: some View {
    Form {
      Toggle(
        "Hide ports above 9999",
        isOn: model.$hidePortsAbove4Digits
      )
    }
    .padding(20)
    .frame(width: 350, height: 100)
  }
}

#Preview {
  SettingsView()
}
