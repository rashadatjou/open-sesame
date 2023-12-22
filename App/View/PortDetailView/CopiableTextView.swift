// CopiableTextView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 10/12/2023

import AppKit
import SwiftUI

struct CopiableTextView: View {
  // - Props
  var detailText: String
  var mainText: String

  // - State
  @State
  private var isTapped = false

  var body: some View {
    VStack(alignment: .leading) {
      Text(detailText)
        .font(.subheadline)
      Text(mainText)
        .font(.headline)
    }
    .scaleEffect(isTapped ? 0.97 : 1.0) // Slightly scale down when tapped
    .opacity(isTapped ? 0.8 : 1.0) // Slightly reduce opacity when tapped
    .animation(.easeOut(duration: 0.2), value: isTapped)
    .onTapGesture {
      isTapped = true

      copyToPasteboard(text: mainText)
      
      // Reset the state after a short delay
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        isTapped = false
      }
    }
  }

  func copyToPasteboard(text: String) {
    let pasteBoard = NSPasteboard.general
    pasteBoard.clearContents()
    pasteBoard.setString(
      text,
      forType: .string
    )
  }
}

#Preview {
  CopiableTextView(
    detailText: "Bundle ID",
    mainText: "app.do.some.com"
  )
}
