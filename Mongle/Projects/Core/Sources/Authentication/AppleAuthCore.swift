//
//  AppleAuthCore.swift
//  Core
//
//  Created by bulmang on 5/15/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import AuthenticationServices
import ComposableArchitecture

@Reducer
public struct AppleAuthCore {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var userIdentifier: String = ""
        public var fullName: String = ""
        public var name: String = ""
        public var email: String = ""
        public var identityToken: String = ""
        public var authorizationCode: String = ""

        public init() {}
    }
    
    public enum Action {
        case login(ASAuthorizationAppleIDCredential)
        case loginInfoPrint
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .login(credentials):
                state.userIdentifier = credentials.user
                state.fullName = (credentials.fullName?.familyName ?? "") + (credentials.fullName?.givenName ?? "")
                state.email = credentials.email?.debugDescription ?? ""
                state.identityToken = String(data: credentials.identityToken!, encoding: .utf8) ?? ""
                state.authorizationCode = String(data: credentials.authorizationCode!, encoding: .utf8) ?? ""
                print("state: \(state)")
                    
                return .none
                
            case .loginInfoPrint:
                print("user identifier: \(state.userIdentifier)")
                print("user identityToken: \(state.identityToken)")
                print("user fullName: \(state.fullName)")
                print("email: \(state.email)")
                print("authorizationCode: \(state.authorizationCode)")
                return .none
            }
        }
    }
}
