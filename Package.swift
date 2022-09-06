// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "KippleTools",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "kipple", targets: ["kipple"]),
        .library(name: "KippleToolsCore", targets: ["KippleToolsCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.4"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.49.17"),
    ],
    targets: [
        // Executable Targets
        .executableTarget(
            name: "kipple",
            dependencies: [
                .target(name: "KippleFramework"),
            ]
        ),
        // Product Targets
        .target(
            name: "KippleFramework",
            dependencies: [
                .target(name: "KippleToolsCore"),
                .product(name: "SwiftFormat", package: "SwiftFormat"),
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "KippleToolsCore",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        // Test Targets
        .testTarget(
            name: "KippleFrameworkTests",
            dependencies: [
                .target(name: "KippleFramework"),
            ]
        ),
        .testTarget(
            name: "KippleToolsCoreTests",
            dependencies: [
                .target(name: "KippleToolsCore"),
            ]
        ),
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-commit": ["echo hello world"], //"swift run kipple format"],
        ],
    ])
#endif
