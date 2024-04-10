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
        hasResources: Bool = false
    ) -> Project {
        
        let deploymentTarget = Environment.deploymentTarget
        var projectTargets: [Target] = []
        var schemes: [Scheme] = []
        
        createSourceDirectory(directoryPath: directoryPath)
        
        // MARK: - App
        
        if targets.contains(.app) {
            let bundleSuffix = "demo"
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
                entitlements: nil,
                scripts: [.SwiftLintString],
                dependencies: [
                    internalDependencies,
                    externalDependencies,
                    [
                    ]
                ].flatMap { $0 },
                settings: nil
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
                bundleId: "\(Environment.bundlePrefix).\(name)Demo",
                deploymentTargets: deploymentTarget,
                infoPlist: .extendingDefault(with: Project.demoInfoPlist),
                sources: ["Demo/Sources/**/*.swift"],
                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                dependencies: [
                    deps,
                    [
                    ]
                ].flatMap { $0 },
                settings: nil
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
                bundleId: "\(Environment.bundlePrefix).\(name)Tests",
                deploymentTargets: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
                dependencies: [
                    deps,
                    [
                    ]
                ].flatMap { $0 },
                settings: nil
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
                bundleId: "\(Environment.bundlePrefix).\(name)UITests",
                deploymentTargets: deploymentTarget,
                infoPlist: .default,
                sources: ["UITests/Sources/**/*.swift"],
                dependencies: [
                    deps,
                    [
                    ]
                ].flatMap { $0 },
                settings: nil
            )
            
            projectTargets.append(target)
        }
        
        
        return Project(
            name: name,
            organizationName: Environment.workspaceName,
            packages: packages,
            settings: nil,
            targets: projectTargets,
            schemes: []
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
        let fileURL = sourcesURL.appendingPathComponent("Demo.swift")
        try "".write(to: fileURL, atomically: true, encoding: .utf8)
        print("\n'Dummy.swift' File created ✅\n")
        
        // Create Resources directory
        if folderName == "Demo" {
            let reSourcesURL = directoryURL.appendingPathComponent("Resources")
            try fileManager.createDirectory(at: reSourcesURL, withIntermediateDirectories: true, attributes: nil)
            print("\nResources directory created ✅\n")
            
            let fileURL = reSourcesURL.appendingPathComponent("Demo.swift")
            try "".write(to: fileURL, atomically: true, encoding: .utf8)
            print("\n'Dummy.swift' File created ✅\n")
        }
        
    } catch {
        print("\nError creating directory ❌\n -> \(error.localizedDescription)\n")
    }
}

private func createSourceDirectory(directoryPath: String) {
    guard directoryPath != "" else { return }
    
    let fileManager = FileManager.default
    let directoryURL = URL(fileURLWithPath: directoryPath)
    let sourcesURL = directoryURL.appendingPathComponent("Sources")
    do {
        if fileManager.fileExists(atPath: sourcesURL.path) {
            print("\n----------------------------------------\n Sources already exists ☑️\n----------------------------------------")
            return
        }
        
        try fileManager.createDirectory(at: sourcesURL, withIntermediateDirectories: true, attributes: nil)
        print("\nSources directory created ✅\n")
    } catch {
        print("\nError creating directory ❌\n -> \(error.localizedDescription)\n")
    }
}
