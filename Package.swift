// swift-tools-version: 5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "typed-notifications",
    platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(name: "TypedNotifications", targets: ["TypedNotifications"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/mtj0928/userinfo-representable", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "TypedNotifications",
            dependencies: [
                .product(name: "UserInfoRepresentable", package: "userinfo-representable"),
                "TypedNotificationsMacro"
            ]
        ),
        .macro(
            name: "TypedNotificationsMacro",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .testTarget(name: "TypedNotificationsTests", dependencies: ["TypedNotifications"]),
        .testTarget(
            name: "TypedNotificationsMacroTests",
            dependencies: [
                "TypedNotificationsMacro",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        )
    ]
)
