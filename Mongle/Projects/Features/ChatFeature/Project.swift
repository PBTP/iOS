//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Features.chatFeature.name,
    targets: [.demo, .frameWork],
    directoryPath: Features.chatFeature.path.pathString,
    internalDependencies: [Features.baseFeature.project]
)
