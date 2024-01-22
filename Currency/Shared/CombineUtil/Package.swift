// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineUtil",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CombineUtil",
            targets: ["CombineUtil"]
        )
    ],
    targets: [
        .target(
            name: "CombineUtil"
        ),
        .testTarget(
            name: "CombineUtilTests",
            dependencies: ["CombineUtil"]
        )
    ]
)
