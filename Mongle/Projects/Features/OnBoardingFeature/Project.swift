//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/12/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Features.onBoardingFeature.name,
    targets: [.frameWork, .demo],
    directoryPath: Features.onBoardingFeature.path.pathString,
    internalDependencies: [Features.baseFeature.project],
    entitlements: .init("OnBoardingFeatureDemo.entitlements")
)
