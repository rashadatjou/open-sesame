// ContentView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 29/11/2023

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
          .frame(maxWidth: .infinity, alignment: .leading)

        Text(port.name.isEmpty ? "Unknown" : port.name)
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
      .fill(
        Color.gray.opacity(0.2)
      )
  }
}

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

struct ContentView: View {
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

#Preview {
  ContentView()
}
