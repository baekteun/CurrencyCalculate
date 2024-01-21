// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "NetworkingInterface",
            targets: ["NetworkingInterface"]
        ),
        .library(
            name: "Networking",
            targets: ["Networking"]
        ),
        .library(
            name: "NetworkingTesting",
            targets: ["NetworkingTesting"]
        )
    ],
    targets: [
        .target(
            name: "NetworkingInterface",
            path: "Interface"
        ),
        .target(
            name: "Networking",
            dependencies: [
                "NetworkingInterface"
            ]
        ),
        .target(
            name: "NetworkingTesting",
            dependencies: [
                "NetworkingInterface"
            ],
            path: "Testing"
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking",
                "NetworkingTesting"
            ]
        )
    ]
)
