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
        public var userIdentifier: String?
        public var fullName: String?
        public var name: String?
        public var email: String?
        public var identityToken: String?
        public var authorizationCode: String?

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
                print("user identifier: \(String(describing: state.userIdentifier ?? nil))")
                print("user identityToken: \(String(describing: state.identityToken ?? nil))")
                print("user fullName: \(String(describing: state.fullName ?? nil))")
                print("email: \(String(describing: state.email ?? nil))")
                print("authorizationCode: \(String(describing: state.authorizationCode ?? nil))")
                return .none
            }
        }
    }
}
