// ContentView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 29/11/2023

import SwiftUI

struct ContentView: View {
  @StateObject
  private var model = PortModel()

  var body: some View {
    VStack {
      List(model.openPortList, id: \.port) { port in
        Text("Port: \(port.port)")
      }
    }
    .padding()
    .frame(width: 250, height: 300)
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
    .environmentObject(PortModel())
}
