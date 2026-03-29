// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "WorkspaceManager",
    platforms: [
        .macOS(.v11)
    ],
    targets: [
        .executableTarget(
            name: "WorkspaceManager",
            dependencies: [],
            path: "Sources/WorkspaceManager"
        )
    ]
)
