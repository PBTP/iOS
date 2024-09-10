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
        
        //TODO: Relase, Dev 버전에 맞춰 bundleSuffix를 변경해야함.
        let bundleSuffix = "dev"
        let deploymentTarget = Environment.deploymentTarget
        var projectTargets: [Target] = []
        let settings: Settings? = .settings(
            base: [
                "DEVELOPMENT_TEAM": "\(APIKey.developmentTeam)",
                "CODE_SIGN_STYLE": "Manual",
                "PROVISIONING_PROFILE_SPECIFIER": "Mongle.dev",
                "CODE_SIGN_IDENTITY": "\(APIKey.codeSignIdentity)"
            ],
            configurations: [
            ]
        )
        
        let schemes: [Scheme] = [
            Scheme.scheme(
                name: "App",
                shared: true,
                buildAction: BuildAction.buildAction(targets: ["App"]),
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
                )
            )
        ]
        
        createDirectory(directoryname: "Sources", directoryPath: directoryPath)
        hasResources ? createDirectory(directoryname: "Resources", directoryPath: directoryPath) : ()
        
        // MARK: - App
        
        if targets.contains(.app) {
            let infoPlist = Project.demoInfoPlist
            
            let target = Target.target(
                name: name,
                destinations: .iOS,
                product: .app,
                bundleId: "\(Environment.bundlePrefix).\(bundleSuffix)",
                deploymentTargets: deploymentTarget,
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Sources/**/*.swift"],
                resources: [.glob(pattern: "Resources/**", excluding: [])],
                entitlements: .init("App.entitlements"),
                scripts: [.SwiftLintString],
                dependencies: [
                    internalDependencies,
                    externalDependencies,
                    [
                    ]
                ].flatMap { $0 },
                settings: settings
            )
            
            projectTargets.append(target)
        }
        
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
                dependencies: internalDependencies + externalDependencies,
                settings: nil
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Feature Executable
        
        if targets.contains(.demo) {
            createDirectoryAtCustomPath(folderName: "Demo", directoryPath: directoryPath)
            
            let deps: [TargetDependency] = [.target(name: name)]
            
            let target = Target.target(
                name: "\(name)Demo",
                destinations: .iOS,
                product: .app,
                bundleId: "\(Environment.bundlePrefix).\(bundleSuffix)",
                deploymentTargets: deploymentTarget,
                infoPlist: .extendingDefault(with: Project.demoInfoPlist),
                sources: ["Demo/Sources/**/*.swift"],
                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                entitlements: entitlements,
                dependencies: [
                    deps,
                    [
                    ]
                ].flatMap { $0 },
                settings: settings
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Unit Tests
        
        if targets.contains(.unitTest) {
            let deps: [TargetDependency] = [.target(name: name)]
            
            let target = Target.target(
                name: "\(name)Tests",
                destinations: .iOS,
                product: .unitTests,
                bundleId: "\(Environment.bundlePrefix).\(bundleSuffix)Test",
                deploymentTargets: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
                dependencies: [
                    deps,
                    [
                    ]
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
                bundleId: "\(Environment.bundlePrefix).\(bundleSuffix)UITest",
                deploymentTargets: deploymentTarget,
                infoPlist: .default,
                sources: ["UITests/Sources/**/*.swift"],
                dependencies: [
                    deps,
                    [
                    ]
                ].flatMap { $0 },
                settings: settings
            )
            
            projectTargets.append(target)
        }
        
        
        return Project(
            name: name,
            organizationName: Environment.workspaceName,
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
