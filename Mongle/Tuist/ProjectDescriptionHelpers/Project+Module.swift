//
//  Project+Module.swift
//  ProjectDescriptionHelpers
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription

public enum Module {
    case app
    
    case core
    
    case thirdPartyLibraryLib
    
    case ui
}

extension Module {
    public var name: String {
        switch self {
        case .app:
            return "App"
        case .thirdPartyLibraryLib:
            return "ThirdPartyLibraryLib"
        case .core:
            return "Core"
        case .ui:
            return "Ui"
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

public enum Ui {
    case designSystem
}

extension Ui {
    public var name: String {
        switch self {
        case .designSystem:
            return "DesignSystem"
        }
    }
    
    public var path: ProjectDescription.Path {
        return .relativeToRoot("Projects/Ui/" + self.name)
    }
    
    public var project: TargetDependency {
        return .project(target: self.name, path: self.path)
    }
}

extension Ui: CaseIterable { }
