//
//  Dependencies.swift
//  MongleManifests
//
//  Created by bulmang on 3/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependecies = Dependencies(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies(
            [
              .remote(
                url: "https://github.com/pointfreeco/swift-composable-architecture.git",
                requirement: .upToNextMajor(from: "1.9.0")
              )
            ],
        baseSettings: .settings(
            configurations: [
              .debug(name: "DEV"),
              .debug(name: "RELEASE"),
              .release(name: "MASTER")
            ]
          ),
        targetSettings: [:]
    ),
    platforms: [.iOS]
)
