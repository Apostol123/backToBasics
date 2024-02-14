// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUI",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftUI",
            targets: ["SwiftUI"]),
    ],
    dependencies: [.package(name: "NetworkServiceAbstractionLayer", path: "/Network/NetworkServiceAbstractionLayer"),
                   .package(name: "URLRequestFactory", path: "/Network/URLRequestFactory"),
                   .package(name: "Stubs", path: "/Network/Stubs")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftUI",
            dependencies: ["NetworkServiceAbstractionLayer", "URLRequestFactory"]),
        
        .testTarget(
            name: "SwiftUITests",
            dependencies: ["SwiftUI"]),
    ]
)
