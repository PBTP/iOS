//
//  UserDefaultsWrapper.swift
//  Core
//
//  Created by Bokyung on 1/26/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    private let key: String
    private let defaultValue: T

    init(_ key: UserDefaultsKey, defaultValue: T) {
        self.key = key.rawValue
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

public class UserSettings {
    @UserDefault(.uuid, defaultValue: "")
    public static var uuid: String

    @UserDefault(.username, defaultValue: "")
    public static var username: String

    @UserDefault(.authProvider, defaultValue: "")
    public static var authProvider: String

    @UserDefault(.isLoggedIn, defaultValue: false)
    public static var isLoggedIn: Bool

    @UserDefault(.accessToken, defaultValue: "")
    public static var accessToken: String

    @UserDefault(.refreshToken, defaultValue: "")
    public static var refreshToken: String
}
