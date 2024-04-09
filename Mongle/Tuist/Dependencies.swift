//
//  Dependencies.swift
//  MongleManifests
//
//  Created by bulmang on 3/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let spm = SwiftPackageManagerDependencies([
    .remote(
        url: "https://github.com/pointfreeco/swift-composable-architecture.git",
        requirement: .upToNextMajor(from: "1.9.0")
    )
])

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: spm,
    platforms: [.iOS]
)


