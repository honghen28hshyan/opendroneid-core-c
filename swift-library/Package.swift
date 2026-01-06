// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenDroneIDSwift",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_15)
    ],
    products: [
        // The Swift library product
        .library(
            name: "OpenDroneIDSwift",
            targets: ["OpenDroneIDSwift"]),
    ],
    dependencies: [
        // No external dependencies
    ],
    targets: [
        // C library target
        .target(
            name: "OpenDroneIDC",
            dependencies: [],
            path: "../libopendroneid",
            sources: ["opendroneid.c", "wifi.c"],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("."),
                .define("_FORTIFY_SOURCE", to: "2"),
            ]
        ),
        
        // Objective-C bridge target
        .target(
            name: "OpenDroneIDObjC",
            dependencies: ["OpenDroneIDC"],
            path: "Sources/OpenDroneIDObjC",
            publicHeadersPath: "."
        ),
        
        // Swift library target
        .target(
            name: "OpenDroneIDSwift",
            dependencies: ["OpenDroneIDObjC"],
            path: "Sources/OpenDroneIDSwift"
        ),
    ]
)
