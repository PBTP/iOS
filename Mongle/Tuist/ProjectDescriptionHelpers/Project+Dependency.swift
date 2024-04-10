//
//  Project+Dependency.swift
//  Manifests
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let ComposableArchitecture = TargetDependency.external(name: "ComposableArchitecture")
}

