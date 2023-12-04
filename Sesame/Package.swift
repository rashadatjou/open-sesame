// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Sesame",
  defaultLocalization: "en",
  platforms: [
    .macOS(.v10_15),
  ],
  products: [
    .library(
      name: "Sesame",
      targets: ["Sesame"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/binarybirds/shell-kit", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "Sesame",
      dependencies: [
        .product(name: "ShellKit", package: "shell-kit"),
      ],
      path: "./Sources"
    ),
  ]
)
