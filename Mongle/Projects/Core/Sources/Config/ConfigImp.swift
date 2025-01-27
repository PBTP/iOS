//
//  ConfigImp.swift
//  Mongle
//
//  Created by Bokyung on 9/18/24.
//  Copyright © 2024 Mongle. All rights reserved.
//

import Foundation

public class ConfigImp: Config {
    public init() {}
    enum ConfigKey: String {
        case baseURL = "BASE_URL"
        case webBaseURL = "WEB_BASE_URL"
    }

    private let dic: [String: String] = {
        guard let dic = Bundle.main.object(forInfoDictionaryKey: "Config") as? [String: String] else {
            return [:]
        }
        return dic
    }()
    
    private func url(forKey key: ConfigKey) -> String {
        guard let url = dic[key.rawValue] else {
            fatalError("url for key \"\(key.rawValue)\" not defined")
        }
        return "https://\(url)"
    }

    private func value(forKey key: ConfigKey) -> String {
        guard let value = dic[key.rawValue] else {
            fatalError("value for key \"\(key.rawValue)\" not defined")
        }
        return value
    }

    public var baseURL: String { url(forKey: .baseURL) }
    public var webBaseURL: String { url(forKey: .webBaseURL) }

    var versionNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }

    var buildNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
}
