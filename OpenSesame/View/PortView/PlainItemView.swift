// PlainItemView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import SwiftUI

struct PlainItemView: View {
  // - Prop
  var title: String
  var shortcut: String

  // - State
  @State
  private var isSelected: Bool = false

  var body: some View {
    HStack {
      Text(title)
      Spacer()
      Text(shortcut)
        .foregroundColor(.gray)
        .font(.subheadline)
    }
    .padding(6)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(isSelected ? Color.white.opacity(0.2) : Color.clear)
    .foregroundColor(isSelected ? .white : .primary)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(Color.gray.opacity(0.5), lineWidth: isSelected ? 0 : 1)
    )
    .onHover(perform: { isHovering in
      isSelected = isHovering
    })
  }
}
