//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Features.rootFeature.name,
    targets: [.frameWork],
    directoryPath: Features.rootFeature.path.pathString,
    internalDependencies: [
        Features.onBoardingFeature.project,
        Features.homeFeature.project,
        Features.calendarFeature.project,
        Features.chatFeature.project,
        Features.profileFeature.project,
    ]
)

