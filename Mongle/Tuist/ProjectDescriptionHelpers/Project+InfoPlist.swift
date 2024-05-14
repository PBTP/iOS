//
//  Project+InfoPlist.swift
//  ProjectDescriptionHelpers
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription

public extension Project {
    static let appInfoPlist: [String: Plist.Value] = [
        "CFBundleShortVersionString": "\(Environment.version)",
        "CFBundleVersion": "\(Environment.bundleVersion)",
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleIdentifier": "\(Environment.bundlePrefix).release",
        "DEFINES_MODULE": "NO",
        "LSApplicationQueriesSchemes" : [
            "kakaokompassauth",
            "kakaolink"
        ],
        "CFBundleURLTypes": [
            [
                "CFBundleTypeRole": "Editor",
                "CFBundleURLSchemes": ["kakao\(APIKey.kakaoAppKey)"]
            ]
        ],
        "UILaunchStoryboardName": "LaunchScreen",
        "Launch Screen" : [
            "Image Name" : "logo",
            "Background color" : "splash_color"
        ],
        "UISupportedInterfaceOrientations":
            [
                "UlInterfaceOrientationPortrait"
            ]
    ]
    
    static let demoInfoPlist: [String: Plist.Value] = [
        "CFBundleShortVersionString": "\(Environment.version)",
        "CFBundleVersion": "\(Environment.bundleVersion)",
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleIdentifier": "\(Environment.bundlePrefix).demo",
        "DEFINES_MODULE": "NO",
        "LSApplicationQueriesSchemes" : [
            "kakaokompassauth",
            "kakaolink"
        ],
        "CFBundleURLTypes": [
            [
                "CFBundleTypeRole": "Editor",
                "CFBundleURLSchemes": ["kakao\(APIKey.kakaoAppKey)"]
            ]
        ],
        "UILaunchStoryboardName": "LaunchScreen",
        "UILaunchScreen" : [
            "UIImageName" : "logo",
            "UIColorName" : "splash_color"
        ],
        "UISupportedInterfaceOrientations":
            [
                "UlInterfaceOrientationPortrait"
            ]
    ]
}
