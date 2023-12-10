// DetailTextView.swift
// OpenSesame by @rashadatjou
// macOS(13.6) with Swift(5.0)
// 10/12/2023

import SwiftUI

struct DetailTextView: View {
  var detailText: String
  var mainText: String

  var body: some View {
    VStack(alignment: .leading) {
      Text(detailText)
        .font(.subheadline)
      Text(mainText)
        .font(.headline)
    }
  }
}


#Preview {
  DetailTextView(
    detailText: "Bundle ID",
    mainText: "app.do.some.com"
  )
}
