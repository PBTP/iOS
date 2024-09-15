//
//  Project+Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription

public extension Project {
    enum Environment {
        public static let workspaceName = "Mongle"
        public static let deploymentTarget = DeploymentTargets.iOS("16.0")
        public static let bundlePrefix = "com.mongle"
        public static let version = "0.0.1"
        public static let bundleVersion = "1"
    }
}
