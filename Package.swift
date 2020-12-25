// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "apple-device-identifieres",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DeviceIdentifiers",
            targets: ["DeviceIdentifiers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sersoft-gmbh/swift-sysctl.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DeviceIdentifiers",
            dependencies: [
                .product(name: "Sysctl", package: "swift-sysctl"),
            ]),
        .testTarget(
            name: "DeviceIdentifiersTests",
            dependencies: ["DeviceIdentifiers"]),
    ]
)
