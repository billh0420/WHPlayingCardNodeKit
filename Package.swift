// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WHPlayingCardNodeKit",
    platforms: [.iOS(.v9), .macOS(.v10_11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WHPlayingCardNodeKit",
            targets: ["WHPlayingCardNodeKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "WHCrossPlatformKit", path: "../WHCrossPlatformKit"),
        .package(name: "WHPlayingCardKit", path: "../WHPlayingCardKit"),
        .package(name: "WHPlayingCardImageKit", path: "../WHPlayingCardImageKit")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WHPlayingCardNodeKit",
            dependencies: ["WHCrossPlatformKit", "WHPlayingCardKit", "WHPlayingCardImageKit"]),
        .testTarget(
            name: "WHPlayingCardNodeKitTests",
            dependencies: ["WHPlayingCardNodeKit"]),
    ]
)