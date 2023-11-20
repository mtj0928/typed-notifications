// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "typed-notifications",
    platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(name: "TypedNotifications", targets: ["TypedNotifications"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(name: "TypedNotifications"),
        .testTarget(name: "TypedNotificationsTests", dependencies: ["TypedNotifications"]),
    ]
)
