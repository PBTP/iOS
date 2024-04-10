//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Features.homeFeature.name,
    targets: [.demo, .frameWork],
    directoryPath: Features.homeFeature.path.pathString,
    internalDependencies: [Features.baseFeature.project]
)

