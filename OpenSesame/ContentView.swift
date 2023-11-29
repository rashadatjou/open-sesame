// ContentView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 29/11/2023

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "circle")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Open, Sesame!")
    }
    .padding()
    .frame(width: 250, height: 300)
  }
}

#Preview {
  ContentView()
}
