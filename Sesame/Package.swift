// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Sesame",
  defaultLocalization: "en",
  platforms: [
    .macOS(.v11),
  ],
  products: [
    .library(
      name: "Sesame",
      targets: ["Sesame"]
    ),
    .library(
      name: "AppDependencies",
      targets: ["AppDependencies"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/binarybirds/shell-kit", from: "1.0.0"),
    .package(url: "https://github.com/orchetect/SettingsAccess", from: "1.4.0"),
    .package(url: "https://github.com/sindresorhus/LaunchAtLogin", from: "5.0.0"),
  ],
  targets: [
    .target(
      name: "Sesame",
      dependencies: [
        .product(name: "ShellKit", package: "shell-kit"),
      ],
      path: "./Sources"
    ),
    .target(
      name: "AppDependencies",
      dependencies: [
        .product(name: "SettingsAccess", package: "SettingsAccess"),
        .product(name: "LaunchAtLogin", package: "LaunchAtLogin")
      ],
      path: "./Other"
    ),
  ]
)
