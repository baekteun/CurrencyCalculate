// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIKitUtil",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UIKitUtil",
            targets: ["UIKitUtil"]
        )
    ],
    targets: [
        .target(
            name: "UIKitUtil"
        ),
        .testTarget(
            name: "UIKitUtilTests",
            dependencies: ["UIKitUtil"]
        )
    ]
)
