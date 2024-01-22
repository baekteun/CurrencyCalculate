// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CCLayout",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CCLayout",
            targets: ["CCLayout"]
        )
    ],
    targets: [
        .target(
            name: "CCLayout"
        ),
        .testTarget(
            name: "CCLayoutTests",
            dependencies: ["CCLayout"]
        )
    ]
)
