// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TemplateRunner",
    products: [
            .executable(name: "template-runner", targets: ["TemplateRunner"])
        ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.1"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.13.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TemplateRunner",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Stencil", package: "Stencil"),
            ]),
        .testTarget(
            name: "TemplateRunnerTests",
            dependencies: ["TemplateRunner"]),
    ]
)
