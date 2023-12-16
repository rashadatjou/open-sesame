// PlainItemView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import SwiftUI

struct PlainItemView: View {
  // - Prop
  var title: String
  var shortcut: String
  var action: () -> Void

  // - State
  @State
  private var isSelected: Bool = false

  var body: some View {
    Button(action: action) {
      HStack {
        Text(title)
        Spacer()
        Text(shortcut)
          .foregroundColor(.gray)
          .font(.subheadline)
      }
      .padding(6)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(isSelected ? Material.thin : Material.thick)
      .foregroundColor(isSelected ? .accentColor : .primary)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .onHover(perform: { isSelected = $0 })
    }
    .buttonStyle(.plain)
  }
}
