import Foundation
import ProjectDescription

public extension Project {
    static func makeModule(
        name: String,
        targets: Set<FeatureTarget> = Set([ .unitTest, .demo]),
        directoryPath: String = "",
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],  // 모듈간 의존성
        externalDependencies: [TargetDependency] = [],  // 외부 라이브러리 의존성
        dependencies: [TargetDependency] = [],
        hasResources: Bool = false,
        entitlements: Entitlements? = nil,
        schemes: [Scheme] = []
    ) -> Project {
        let deploymentTarget = Environment.deploymentTarget
        var projectTargets: [Target] = []
        
        enum ConfigurationType: String {
            case dev = "dev"
            case release = "release"
        }

        func signingSettings(for config: ConfigurationType) -> [String: SettingValue] {
            return [
                "PRODUCT_BUNDLE_IDENTIFIER": "com.mongle.\(config.rawValue)",
                "PROVISIONING_PROFILE_SPECIFIER": "Mongle.\(config.rawValue)",
                "CODE_SIGN_IDENTITY": "\(APIKey.codeSignIdentity)"
            ]
        }
        let settings: Settings? = .settings(
            base: [
                "CODE_SIGN_STYLE": "Manual",
                "DEVELOPMENT_TEAM": "\(APIKey.developmentTeam)",
                "CODE_SIGN_IDENTITY": "\(APIKey.codeSignIdentity)"
            ],
            configurations: [
                .debug(
                    name: .configuration("Debug"),
                    settings: signingSettings(for: .dev),
                    xcconfig: .relativeToRoot("Config/Debug.xcconfig")
                ),
                .release(
                    name: .configuration("Release"),
                    settings: signingSettings(for: .release),
                    xcconfig: .relativeToRoot("Config/Release.xcconfig")
                )
            ]
        )

        // MARK: Scheme
        let schemes: [Scheme] = [
            Scheme.scheme(
                name: "Mongle",
                shared: true,
                buildAction: BuildAction.buildAction(targets: ["Mongle"]),
                runAction: .runAction(
                    configuration: .release,
                    preActions: [],
                    postActions: [],
                    arguments: Arguments.arguments(
                        environmentVariables: [
                            "KAKAO_APP_KEY": EnvironmentVariable(stringLiteral: APIKey.kakaoAppKey)
                        ],
                        launchArguments: []
                    ),
                    options: .options(),
                    diagnosticsOptions: .options(),
                    expandVariableFromTarget: nil
                ),
                archiveAction: .archiveAction(
                    configuration: .release
                )
            ),
            Scheme.scheme(
                name: "Mongle-dev",
                shared: true,
                buildAction: BuildAction.buildAction(targets: ["Mongle"]),
                runAction: .runAction(
                    configuration: .debug,
                    preActions: [],
                    postActions: [],
                    arguments: Arguments.arguments(
                        environmentVariables: [
                            "KAKAO_APP_KEY": EnvironmentVariable(stringLiteral: APIKey.kakaoAppKey)
                        ],
                        launchArguments: []
                    ),
                    options: .options(),
                    diagnosticsOptions: .options(),
                    expandVariableFromTarget: nil
                ),
                archiveAction: .archiveAction(
                    configuration: .debug
                )
            )
        ]
        
        createDirectory(directoryname: "Sources", directoryPath: directoryPath)
        hasResources ? createDirectory(directoryname: "Resources", directoryPath: directoryPath) : ()
        
        // MARK: - App

        if targets.contains(.app) {
            let infoPlist = Project.devInfoPlist
            let target = Target.target(
                name: "Mongle",
                destinations: .iOS,
                product: .app,
                productName: "Mongle",
                bundleId: "\(Environment.bundlePrefix)",
                deploymentTargets: deploymentTarget,
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Sources/**/*.swift"],
                resources: [.glob(pattern: "Resources/**", excluding: [])],
                entitlements: .init("App.entitlements"),
                scripts: [.SwiftLintString],
                dependencies: [
                    internalDependencies,
                    externalDependencies
                ].flatMap { $0 },
                settings: settings
            )
            projectTargets.append(target)
        }

        // MARK: - Demo

        if targets.contains(.demo) {
            createDirectoryAtCustomPath(folderName: "Demo", directoryPath: directoryPath)
            let deps: [TargetDependency] = [.target(name: name)]
            let target = Target.target(
                name: "\(name)DemoApp",
                destinations: .iOS,
                product: .app,
                bundleId: "\(Environment.bundlePrefix)",
                deploymentTargets: deploymentTarget,
                infoPlist: .extendingDefault(with: Project.devInfoPlist),
                sources: ["Demo/Sources/**/*.swift"],
                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                entitlements: entitlements,
                scripts: [.SwiftLintString],
                dependencies: [
                    deps
                ].flatMap { $0 },
                settings: settings
            )
            projectTargets.append(target)
        }

        // MARK: - UI Tests

        if targets.contains(.uiTest) {
            let deps: [TargetDependency] = targets.contains(.demo)
            ? [.target(name: name), .target(name: "\(name)Demo")] : [.target(name: name)]
            let target = Target.target(
                name: "\(name)UITests",
                destinations: .iOS,
                product: .uiTests,
                bundleId: "\(Environment.bundlePrefix).UITest",
                deploymentTargets: deploymentTarget,
                infoPlist: .default,
                sources: ["UITests/Sources/**/*.swift"],
                scripts: [.SwiftLintString],
                dependencies: [
                    deps
                ].flatMap { $0 },
                settings: settings
            )
            projectTargets.append(target)
        }
        
        // MARK: - Unit Tests
        
        if targets.contains(.unitTest) {
            let deps: [TargetDependency] = [.target(name: name)]
            let target = Target.target(
                name: "\(name)UnitTests",
                destinations: .iOS,
                product: .unitTests,
                bundleId: "\(Environment.bundlePrefix).UnitTest",
                deploymentTargets: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
                scripts: [.SwiftLintString],
                dependencies: [
                    deps
                ].flatMap { $0 },
                settings: settings
            )
            projectTargets.append(target)
        }

        // MARK: - FrameWork

        if targets.contains(.frameWork) {
            let target = Target.target(
                name: name,
                destinations: .iOS,
                product: .framework,
                bundleId: "\(Environment.bundlePrefix).\(name)",
                deploymentTargets: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**/*.swift"],
                resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
                scripts: [.SwiftLintString],
                dependencies: internalDependencies + externalDependencies,
                settings: nil
            )

            projectTargets.append(target)
        }

        
        return Project(
            name: name,
            organizationName: Project.Environment.workspaceName,
            packages: packages,
            settings: nil,
            targets: projectTargets,
            schemes: schemes
        )
    }
}

private func createDirectoryAtCustomPath(folderName: String, directoryPath: String) {
    guard directoryPath != "" else { return }
    let directoryName = folderName // 폴더 이름 설정
    let directoryURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(directoryName) // 변경할 경로 지정
    let fileManager = FileManager.default
    do {
        if fileManager.fileExists(atPath: directoryURL.path) {
            print("\n----------------------------------------\n'\(directoryName)' already exists ☑️\n----------------------------------------")
            return
        }
        // Create Demo directory
        try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        print("\n'\(directoryName)' Directory created ✅\n")
        
        // Create Sources directory inside Demo
        let sourcesURL = directoryURL.appendingPathComponent("Sources")
        try fileManager.createDirectory(at: sourcesURL, withIntermediateDirectories: true, attributes: nil)
        print("\nSources directory created ✅\n")
        
        // Create Dummy.swift file Sources Directory
        createDirectory(directoryname: "Sources", directoryPath: directoryURL.absoluteString)
        
        // Create Resources directory
        if folderName == "Demo" {
            createDirectory(directoryname: "Resources", directoryPath: directoryURL.absoluteString)
        }
        
    } catch {
        print("\nError creating directory ❌\n -> \(error.localizedDescription)\n")
    }
}

private func createDirectory(directoryname: String, directoryPath: String) {
    guard directoryPath != "" else { return }
    
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: directoryPath)
    let directoryNameURL = directoryURL.appendingPathComponent(directoryname)
    do {
        if fileManager.fileExists(atPath: directoryNameURL.path) {
            print("\n----------------------------------------\n \(directoryname) already exists ☑️\n----------------------------------------")
            return
        }
        
        try fileManager.createDirectory(at: directoryNameURL, withIntermediateDirectories: true, attributes: nil)
        print("\n\(directoryname) directory created ✅\n")
    } catch {
        print("\nError creating directory ❌\n -> \(error.localizedDescription)\n")
    }
    
    createDummyFile(directoryURL: directoryNameURL)
}

// Create Dummy.swift file
private func createDummyFile(directoryURL: URL) {
    let fileURL = (directoryURL).appendingPathComponent("Dummy.swift")
    do {
        try "".write(to: fileURL, atomically: true, encoding: .utf8)
        print("\n'Dummy.swift' File created ✅\n")
    } catch {
        print("\nError creating Dummy.swift file ❌\n -> \(error.localizedDescription)\n")
    }
}
