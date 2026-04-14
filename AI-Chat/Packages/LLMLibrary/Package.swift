// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "LLMLibrary",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "LLMLibrary",
            targets: ["LLMLibrary"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.2.0"
        ),
        .package(
            url: "https://github.com/ml-explore/mlx-swift-lm.git",
            revision: "89de43c6c8c36f037da3db22230fa5356463b594"
        ),
        .package(
            url: "git@github.com:Asisiov/swift-tokenizers-mlx.git",
            branch: "main"
        ),
        .package(
            url: "git@github.com:Asisiov/swift-hf-api-mlx.git",
            branch: "main"
        ),
//        .package(
//            url: "https://github.com/ml-explore/mlx-swift-lm.git",
//            branch: "main"
//        ),
//        .package(
//            url: "https://github.com/DePasqualeOrg/swift-tokenizers-mlx.git",
//            from: "0.1.3"
//        ),
//        .package(
//            url: "https://github.com/DePasqualeOrg/swift-hf-api-mlx.git",
//            from: "0.1.1"
//        )
    ],
    targets: [
        .target(
            name: "LLMLibrary",
            dependencies: [
                .product(name: "MLXLLM", package: "mlx-swift-lm"),
                .product(name: "MLXLMTokenizers", package: "swift-tokenizers-mlx"),
                .product(name: "MLXLMHFAPI", package: "swift-hf-api-mlx"),
            ],
            path: "Sources/LLMLibrary"
        )
//        .testTarget(
//            name: "LLMLibraryTests",
//            dependencies: ["LLMLibrary"]
//        )
    ],
    swiftLanguageModes: [.v6]
)
