// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-cursor",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Cursor",
            targets: ["Cursor"]
        ),
        .library(
            name: "Cursor Standard Library Integration",
            targets: ["Cursor Standard Library Integration"]
        ),
        .library(
            name: "Cursor Apple Foundation Integration",
            targets: ["Cursor Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Cursor",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(
                    name: "Ownership Borrow",
                    package: "swift-ownership"
                ),
            ]
        ),
        .target(
            name: "Cursor Standard Library Integration",
            dependencies: ["Cursor"]
        ),
        .target(
            name: "Cursor Apple Foundation Integration",
            dependencies: [
                "Cursor",
                "Cursor Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Cursor Tests",
            dependencies: [
                "Cursor"
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
