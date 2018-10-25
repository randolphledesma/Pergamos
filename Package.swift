// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "pergamos",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.1.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.1"),
        .package(url: "https://github.com/BrettRToomey/Jobs.git", from: "1.1.1")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf", "Jobs"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

