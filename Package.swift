// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "YourProjectName",
    platforms: [
        .macOS(.v10_15), .iOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/mongodb/mongo-swift-driver.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "YourProjectName",
            dependencies: [
                .product(name: "MongoSwift", package: "mongo-swift-driver")
            ]
        ),
    ]
)

