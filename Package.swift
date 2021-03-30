// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MorphologicalAnalysis",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "MorphologicalAnalysis",
            targets: ["MorphologicalAnalysis"]),
    ],
    dependencies: [
        .package(name: "Corpus", url: "https://github.com/StarlangSoftware/Corpus-Swift.git", .exact("1.0.10")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "MorphologicalAnalysis",
            dependencies: ["Corpus"]),
        .testTarget(
            name: "MorphologicalAnalysisTests",
            dependencies: ["MorphologicalAnalysis"]),
    ]
)
