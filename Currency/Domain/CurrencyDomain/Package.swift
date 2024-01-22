// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CurrencyDomain",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CurrencyDomainInterface",
            targets: ["CurrencyDomainInterface"]
        ),
        .library(
            name: "CurrencyDomain",
            targets: ["CurrencyDomain"]
        ),
        .library(
            name: "CurrencyDomainTesting",
            targets: ["CurrencyDomainTesting"]
        )
    ],
    dependencies: [
        .package(path: "../Core/Networking")
    ],
    targets: [
        .target(
            name: "CurrencyDomainInterface",
            path: "Interface"
        ),
        .target(
            name: "CurrencyDomain",
            dependencies: [
                "CurrencyDomainInterface",
                .product(name: "NetworkingInterface", package: "Networking")
            ],
            resources: [
                .process("Resources/Currencylayer.plist")
            ]
        ),
        .target(
            name: "CurrencyDomainTesting",
            dependencies: [
                "CurrencyDomainInterface"
            ],
            path: "Testing"
        ),
        .testTarget(
            name: "CurrencyDomainTests",
            dependencies: [
                "CurrencyDomain",
                "CurrencyDomainTesting",
                .product(name: "NetworkingTesting", package: "Networking")
            ]
        )
    ]
)
