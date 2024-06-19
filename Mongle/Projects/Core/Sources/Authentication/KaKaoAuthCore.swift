//
//  kakaoAuth.swift
//  Core
//
//  Created by bulmang on 6/12/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Foundation
import KakaoSDKUser

public class KaKaoAuthCore: ObservableObject {
    @Published public var customer: Customer
    
    public init() {
        self.customer = Customer()
    }
    
    public func loginKakaoAccount() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    self.getUserInfo()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    self.getUserInfo()
                }
            }
        }
    }
    
    private func getUserInfo() {
        UserApi.shared.me() { [weak self] (user, error) in
            if let error = error {
                print(error)
            } else {
                print("me() success.")
                guard let self = self else { return }
                
                if let uuid = user?.id?.description {
                    self.customer.uuid = uuid
                }
                
                if let customerName = user?.kakaoAccount?.profile?.nickname {
                    self.customer.customerName = customerName
                }
                
                if let customerPhoneNumber = user?.kakaoAccount?.phoneNumber {
                    self.customer.customerPhoneNumber = customerPhoneNumber
                }
                
                self.customer.authProvider = "KAKAO"
                
                print(self.customer)
                
                NetworkManager.shared.sendUserData(customer: customer)
            }
        }
    }
}
