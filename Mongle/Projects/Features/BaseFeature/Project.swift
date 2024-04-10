//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Features.baseFeature.name,
    targets: [.frameWork],
    directoryPath: Features.baseFeature.path.pathString,
    internalDependencies: [
        Module.core.project,
        Module.ui.project
    ]
)
