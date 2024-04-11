//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/11/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Ui.designSystem.name,
    targets: [.frameWork],
    directoryPath: Ui.designSystem.path.pathString,
    hasResources: true
)
