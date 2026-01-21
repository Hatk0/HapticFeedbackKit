// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "HapticFeedbackKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "HapticFeedbackKit",
            targets: ["HapticFeedbackKit"]
        ),
    ],
    targets: [
        .target(
            name: "HapticFeedbackKit"
        ),
        .testTarget(
            name: "HapticFeedbackKitTests",
            dependencies: ["HapticFeedbackKit"]
        ),
    ]
)
