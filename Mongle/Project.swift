import ProjectDescription
import ProjectDescriptionHelpers

private let bundleId = "com.mongleteam"
private let version = "0.0.1"
private let bundleVersion = "1"
private let iOSTargetVersion = "16.0"
private let appName = "PB"

private let basePath = "Targets/Mongle"

let project = Project(
    name: appName, // 프로젝트 이름
    organizationName: bundleId,// org 이름
    options: .options(automaticSchemesOptions: .disabled), // 프로젝트 생성 옵션
    packages: [
        .remote(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            requirement: .upToNextMajor(from: "1.9.0")
          )
    ], // swift package 설정
    settings: .settings(
        configurations: [
            .debug(name: "DEV"),
            .debug(name: "RELEASE"),
            .release(name: "MASTER")
        ]
    ), targets: [
        // DEV Target (개발)
        Target(
            name: "DEV_Mongle",
            destinations: .iOS,
            product: .app,
            bundleId: bundleId,
            deploymentTargets: .iOS(iOSTargetVersion),
            infoPlist: makeInfoPlist(),
            sources: ["\(basePath)/Sources/**"],
            resources: ["\(basePath)/ReSources/**"],
            scripts: [.SwiftLintString],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "DEV", xcconfig: "./Configs/mongle.dev.xcconfig")
                ]
            )
        ),
        // RELEASE Target (테스트)
        Target(
            name: "RELEASE_Mongle",
            destinations: .iOS,
            product: .app,
            bundleId: bundleId,
            deploymentTargets: .iOS(iOSTargetVersion),
            infoPlist: makeInfoPlist(),
            sources: ["\(basePath)/Sources/**"],
            resources: ["\(basePath)/ReSources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "RELEASE", xcconfig: "./Configs/mongle.release.xcconfig")
                ]
            )
        ),
        // MATER Target (배포)
        Target(
            name: "MASTER_Mongle",
            destinations: .iOS,
            product: .app,
            bundleId: bundleId,
            deploymentTargets: .iOS(iOSTargetVersion),
            infoPlist: makeInfoPlist(),
            sources: ["\(basePath)/Sources/**"],
            resources: ["\(basePath)/ReSources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture")
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "MASTER", xcconfig: "./Configs/mongle.master.xcconfig")
                ]
            )
        )
    ],
    additionalFiles: [
      "./Configs/mongle.shared.xcconfig"
    ]
)

private func makeInfoPlist(merging other: [String: Plist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: Plist.Value] = [
        "UIApplicationSceneManifest": ["UIApplicationSupportsMultipleScenes": true],
        "UILaunchScreen": [],
        "UISupportedInterfaceOrientations":
            [
                "UlInterfaceOrientationPortrait"
            ],
        "CFBundleShortVersionString": "\(version)",
        "CFBundleVersion": "\(bundleVersion)",
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)"
    ]
    
    other.forEach { (key: String, value: Plist.Value) in
        extendedPlist[key] = value
    }
    
    return InfoPlist.extendingDefault(with: extendedPlist)
}
