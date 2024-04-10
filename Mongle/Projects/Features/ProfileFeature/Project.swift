//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Features.profileFeature.name,
    targets: [.demo, .frameWork],
    directoryPath: Features.profileFeature.path.pathString,
    internalDependencies: [Features.baseFeature.project]
)
