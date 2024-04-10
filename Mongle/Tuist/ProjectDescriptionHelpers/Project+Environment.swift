//
//  Project+Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription

public enum Environment {
    public static let workspaceName = "Mongle"
}

public extension Project {
    enum Environment {
        public static let workspaceName = "Mongle-iOS"
        public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
        public static let platform = Platform.iOS
        public static let bundlePrefix = "com.Mongle-iOS"
        public static let version = "0.0.1"
        public static let bundleVersion = "1"
    }
}
