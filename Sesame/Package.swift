// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Sesame",
  products: [
    .library(
      name: "Sesame",
      targets: ["Sesame"]
    ),
  ],
  targets: [
    .target(
      name: "Sesame",
      path: "./Sources"
    ),
  ]
)
