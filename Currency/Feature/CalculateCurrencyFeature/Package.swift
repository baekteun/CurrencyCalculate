// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalculateCurrencyFeature",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CalculateCurrencyFeatureInterface",
            targets: ["CalculateCurrencyFeatureInterface"]
        ),
        .library(
            name: "CalculateCurrencyFeature",
            targets: ["CalculateCurrencyFeature"]
        )
    ],
    dependencies: [
        .package(path: "../../Domain/CurrencyDomain"),
        .package(path: "../../Core/CCLayout"),
        .package(path: "../../Shared/Then"),
        .package(path: "../../Shared/UIKitUtil"),
        .package(path: "../../Shared/CombineUtil")
    ],
    targets: [
        .target(
            name: "CalculateCurrencyFeatureInterface",
            path: "Interface"
        ),
        .target(
            name: "CalculateCurrencyFeature",
            dependencies: [
                "CalculateCurrencyFeatureInterface",
                .product(name: "CurrencyDomainInterface", package: "CurrencyDomain"),
                .product(name: "Then", package: "Then"),
                .product(name: "CCLayout", package: "CCLayout"),
                .product(name: "UIKitUtil", package: "UIKitUtil"),
                .product(name: "CombineUtil", package: "CombineUtil")
            ]
        ),
        .testTarget(
            name: "CalculateCurrencyFeatureTests",
            dependencies: [
                "CalculateCurrencyFeature",
                .product(name: "CurrencyDomainTesting", package: "CurrencyDomain")
            ]
        )
    ]
)
