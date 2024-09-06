//
//  Project+InfoPlist.swift
//  ProjectDescriptionHelpers
//
//  Created by bulmang on 4/9/24.
//

import ProjectDescription

public extension Project {
    static func makeInfoPlist(bundleIdentifierSuffix: String) -> [String: Plist.Value] {
        return [
            "CFBundleShortVersionString": "\(Environment.version)",
            "CFBundleVersion": "\(Environment.bundleVersion)",
            "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
            "CFBundleDevelopmentRegion": "ko",
            "CFBundleIdentifier": "\(Environment.bundlePrefix).\(bundleIdentifierSuffix)",
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
            "UISupportedInterfaceOrientations": [
                "UlInterfaceOrientationPortrait"
            ]
        ]
    }

    static let appInfoPlist = makeInfoPlist(bundleIdentifierSuffix: "release")
    static let demoInfoPlist = makeInfoPlist(bundleIdentifierSuffix: "demo")
}
