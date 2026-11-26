// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "Projet_Swift",
    targets: [
        .executableTarget(
            name: "Projet_Swift",
            swiftSettings: [
                .enableUpcomingFeature("ApproachableConcurrency"),
            ]
        )
    ]
)

