// PortDetailView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 09/12/2023

import Sesame
import SwiftUI

struct PortDetailView: View {
  var port: Sesame.Port

  var body: some View {
    Text("Port: \(port.port)")
      .navigationTitle("Port Detail")
  }
}
