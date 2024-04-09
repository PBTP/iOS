//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Module.app.name,
    targets: [.app],
    directoryPath: Module.app.path.pathString,
    internalDependencies: [
        Features.rootFeature.project
    ],
    hasResources: true
)
