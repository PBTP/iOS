// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "ComposableArchitecture": .framework, // default is .staticFramework
            "KakaoSDK": .framework, // default is .staticFramework
        ]
    )

#endif
let package = Package(
    name: "MongleExternalLibrary",
    platforms: [
        .iOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.9.0"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", from: "2.22.1")
    ]
)


