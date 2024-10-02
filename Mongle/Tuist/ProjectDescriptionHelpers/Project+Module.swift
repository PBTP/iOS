//
//  Project+Module.swift
//  ProjectDescriptionHelpers
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription

public enum Module {
    case app
    case ui
    case core
    case thirdPartyLibraryLib
}

extension Module {
    public var name: String {
        switch self {
        case .app:
            return "App"
        case .ui:
            return "UI"
        case .core:
            return "Core"
        case .thirdPartyLibraryLib:
            return "ThirdPartyLibraryLib"
        }
    }
    
    public var path: ProjectDescription.Path {
        return .relativeToRoot("Projects/" + self.name)
    }
    
    public var project: TargetDependency {
        return .project(target: self.name, path: self.path)
    }
}

extension Module: CaseIterable { }

public enum Features {
    case rootFeature
    case onBoardingFeature
    case homeFeature
    case calendarFeature
    case chatFeature
    case profileFeature
    case baseFeature
}

extension Features {
    public var name: String {
        switch self {
        case .rootFeature:
            return "RootFeature"
        case .onBoardingFeature:
            return "OnBoardingFeature"
        case .homeFeature:
            return "HomeFeature"
        case .calendarFeature:
            return "CalendarFeature"
        case .chatFeature:
            return "ChatFeature"
        case .profileFeature:
            return "ProfileFeature"
        case .baseFeature:
            return "BaseFeature"
        }
    }
    public var path: ProjectDescription.Path {
        return .relativeToRoot("Projects/Features/" + self.name)
    }
    
    public var project: TargetDependency {
        return .project(target: self.name, path: self.path)
    }
}

extension Features: CaseIterable { }
