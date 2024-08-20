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
    public struct State {
        public var customer: Customer
        
        public init() {
            self.customer = Customer()
        }
    }
    
    public enum Action {
        case appleButtonTapped(ASAuthorizationAppleIDCredential)
        case login(ASAuthorizationAppleIDCredential)
        case loginError(Error)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .login(credentials):
                state.customer.uuid = credentials.user
                
                if let familyName = credentials.fullName?.familyName, let givenName = credentials.fullName?.givenName {
                    state.customer.customerName = familyName + givenName
                } else {
                    state.customer.customerName = nil
                }
                
                state.customer.authProvider = "APPLE"
                
                NetworkManager().sendUserData(customer: state.customer) { success in
                    
                }
                
                return .none
                
            case let .appleButtonTapped(credientials):
                return .run { send in
                    await send(.login(credientials))
                } catch: { error, send in
                    await send(.loginError(error))
                }
                
            case let .loginError(error):
                print(error)
                return .none
            }
        }
    }
}
