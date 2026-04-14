// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LamaChatModule",
    platforms: [.macOS(.v26)],
    products: [
            .library(
                name: "LamaChatModule",
                targets: ["LamaChatModule"]
            )
    ],
    dependencies: [
//        .package(
//            url: "https://github.com/apple/swift-argument-parser.git",
//            from: "1.2.0"
//        ),
//        .package(
//            url: "https://github.com/ml-explore/mlx-swift-lm.git",
//            revision: "89de43c6c8c36f037da3db22230fa5356463b594"
//        ),
//        .package(
//            url: "git@github.com:Asisiov/swift-tokenizers-mlx.git",
//            branch: "main"
//        ),
//        .package(
//            url: "git@github.com:Asisiov/swift-hf-api-mlx.git",
//            branch: "main"
//        ),
        .package(
            url: "https://github.com/ml-explore/mlx-swift-lm.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/DePasqualeOrg/swift-tokenizers-mlx.git",
            from: "0.1.3"
        ),
        .package(
            url: "https://github.com/DePasqualeOrg/swift-hf-api-mlx.git",
            from: "0.1.1"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
//        .executableTarget(
//            name: "LamaChatModule",
//            dependencies: [
//                .product(name: "ArgumentParser", package: "swift-argument-parser"),
//                .product(name: "MLXLLM", package: "mlx-swift-lm"),
//                .product(name: "MLXLMTokenizers", package: "swift-tokenizers-mlx"),
//                .product(name: "MLXLMHFAPI", package: "swift-hf-api-mlx"),
//            ]
//        ),
        .target(
            name: "LamaChatModule",
            dependencies: [
                .product(name: "MLXLLM", package: "mlx-swift-lm"),
                .product(name: "MLXLMTokenizers", package: "swift-tokenizers-mlx"),
                .product(name: "MLXLMHFAPI", package: "swift-hf-api-mlx"),
            ],
            path: "Sources/LLMKit"
        ),
    ],
    swiftLanguageModes: [.v6]
)
