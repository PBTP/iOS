//
//  Project.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Module.thirdPartyLibraryLib.name,
    targets: [.frameWork],
    directoryPath: Module.thirdPartyLibraryLib.path.pathString,
    externalDependencies: [.SPM.ComposableArchitecture]
)
