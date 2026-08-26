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
            name: "Cursor Primitive",
            targets: ["Cursor Primitive"]
        ),
        .library(
            name: "Cursor",
            targets: ["Cursor"]
        ),
        .library(
            name: "Cursor Test Support",
            targets: ["Cursor Test Support"]
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
            url: "https://github.com/swift-molecules/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Cursor Primitive",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(
                    name: "Ownership Borrow",
                    package: "swift-ownership"
                ),
            ]
        ),

        .target(
            name: "Cursor",
            dependencies: [
                "Cursor Primitive"
            ]
        ),

        .target(
            name: "Cursor Test Support",
            dependencies: [
                "Cursor",
                .product(name: "Index Test Support", package: "swift-index"),
            ],
            path: "Tests/Support"
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
