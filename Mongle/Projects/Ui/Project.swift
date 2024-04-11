//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Module.ui.name,
    targets: [.frameWork],
    directoryPath: Module.ui.path.pathString,
    internalDependencies: [
        Ui.designSystem.project,
        Module.thirdPartyLibraryLib.project
    ],
    hasResources: true
)
