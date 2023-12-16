// SettingsView.swift
// OpenSesame by @rashadatjou
// macOS(14.2) with Swift(5.0)
// 16/12/2023

import SwiftUI

struct SettingsView: View {
  @StateObject
  private var model = SettingModel.shared

  // - Services
  private let formatter: NumberFormatter = {
    let fm = NumberFormatter()
    fm.numberStyle = .decimal
    return fm
  }()

  var body: some View {
    Form {
      VStack(alignment: .leading) {
        fieldDisablePorts
        Spacer(minLength: 8)
        fieldExcludePorts
        Spacer(minLength: 10)
        fieldRefreshInterval
      }
    }
    .frame(width: 350, height: 250)
    .padding(20)
    .navigationTitle("Settings")
  }

  // - Fields
  private var fieldDisablePorts: some View {
    HStack {
      Label(
        "Hide ports above \(formatter.string(from: 10_000)!)",
        systemImage: "eye.slash.circle.fill"
      )
      Spacer()
      Toggle(
        "",
        isOn: model.$hidePortsAbove4Digits
      )
    }
  }

  private var fieldExcludePorts: some View {
    VStack(alignment: .leading) {
      Label(
        "Exclude ports list",
        systemImage: "list.clipboard.fill"
      )

      Spacer(minLength: 12)

      VStack {
        TextEditor(text: model.$excludePortText)
          .scrollContentBackground(.hidden) // <- Hide it
          .background(.clear) // To see this
          .padding(.horizontal, 2)
          .padding(.vertical, 8)
      }
      .background(.background)
      .clipShape(
        .rect(cornerSize:
          .init(width: 10, height: 10)
        )
      )

      Spacer(minLength: 8)

      Text("Separate each port by comma or a new line.")
        .font(.footnote)
    }
  }

  private var fieldRefreshInterval: some View {
    VStack(alignment: .leading) {
      Label(
        "Refresh interval (seconds)",
        systemImage: "arrow.rectanglepath"
      )
      Picker("", selection: model.$refreshInterval) {
        ForEach(model.refreshIntervalList, id: \.self) { option in
          Text(String(option)).tag(option)
        }
      }
      .pickerStyle(.menu)
      .padding(.horizontal, -8)
    }
  }
}

#Preview {
  SettingsView()
}
