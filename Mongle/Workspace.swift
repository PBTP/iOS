//
//  Workspace.swift
//  Config
//
//  Created by bulmang on 3/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspaceName = "Mongle"

let workspace = Workspace(
    name: workspaceName,
    projects: [
        // Module
        Module.app.path,
        Module.core.path,
        Module.ui.path,
        Features.rootFeature.path,
        
        //Features
        Features.onBoardingFeature.path,
        Features.homeFeature.path,
        Features.calendarFeature.path,
        Features.chatFeature.path,
        Features.profileFeature.path,
        Features.baseFeature.path,
        
        // Library
        Module.thirdPartyLibraryLib.path,
    ]
)


