// PortItemView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Sesame
import SwiftUI

struct PortItemView: View {
  // - Props
  var icon: String
  var port: Sesame.Port

  // - State
  @State
  private var isSelected: Bool = false

  var body: some View {
    HStack {
      ZStack {
        Circle()
          .fill(Color.gray.opacity(0.2))
          .frame(width: 32, height: 32)
        Image(systemName: icon)
          .imageScale(.large)
          .fontWeight(.bold)
          .foregroundColor(.white)
      }

      Spacer()

      VStack(alignment: .leading) {
        Text(String(port.port))
          .font(.title)
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity, alignment: .leading)

        Text("PID: " + String(port.pid))
          .font(.subheadline)
          .foregroundColor(.secondary)
      }

      Spacer()

      if isSelected {
        Image(systemName: "chevron.right")
          .foregroundColor(.white)
          .padding(.leading, 8)
      }
    }
    .padding(.horizontal, 10)
    .padding(.vertical, 6)
    .background(background)
    .onHover(perform: { hovering in
      isSelected = hovering
    })
  }

  private var background: some View {
    RoundedRectangle(cornerRadius: 8)
      .fill(Material.ultraThick)
  }
}
