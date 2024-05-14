//
//  AuthenticationReducer.swift
//  Core
//
//  Created by bulmang on 5/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

@Reducer
public struct KaKaoAuthCore {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var kakaoToken: String = ""
        
        public init() {}
    }
    
    public enum Action {
        case loginKakaoAccount
        case logoutKakaoAccount
        case hasToken
        case getTokenInfo
        case getUserInfo
        case unLinkKakaoAccount
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .loginKakaoAccount:
                if UserApi.isKakaoTalkLoginAvailable() {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("loginWithKakaoTalk() success.")
                            
                            //do something
                            _ = oauthToken
                        }
                    }
                } else {
                    UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("loginWithKakaoAccount() success.")
                            
                            //do something
                            _ = oauthToken
                        }
                    }
                }
                return .none
                
            case .logoutKakaoAccount:
                UserApi.shared.logout {(error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("logout() success.")
                    }
                }
                return .none
                
            case .hasToken:
                if AuthApi.hasToken() {
                    UserApi.shared.accessTokenInfo { (_, error) in
                        if let error = error {
                            if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                                print("로그인 필요")
                            }
                            else {
                                print(error)
                            }
                        }
                        else {
                            print("토큰 유효성 체크 성공(필요 시 토큰 갱신됨)")
                        }
                    }
                }
                else {
                    print("로그인 필요")
                }
                return .none
                
            case .getTokenInfo:
                print("getTokenInfo() called")
                UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("accessTokenInfo() success.")
                        
                        //do something
                        _ = accessTokenInfo
                    }
                }
                return .none
                
            case .getUserInfo:
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("me() success.")
                        
                        //do something
                        _ = user
                    }
                }
                return .none
                
            case .unLinkKakaoAccount:
                UserApi.shared.unlink {(error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("unlink() success.")
                    }
                }
                return .none
            }
        }
    }
}
