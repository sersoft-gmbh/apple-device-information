// swift-tools-version:6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: Array<SwiftSetting> = [
    .swiftLanguageMode(.v6),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("InternalImportsByDefault"),
]

let package = Package(
    name: "apple-device-information",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DeviceInformation",
            targets: ["DeviceInformation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/sersoft-gmbh/swift-sysctl", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DeviceInformation",
            dependencies: [
                .product(name: "Sysctl", package: "swift-sysctl"),
            ],
            swiftSettings: swiftSettings),
        .testTarget(
            name: "DeviceInformationTests",
            dependencies: [
                .product(name: "Sysctl", package: "swift-sysctl"),
                "DeviceInformation",
            ],
            swiftSettings: swiftSettings),
    ]
)
