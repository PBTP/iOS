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
    
    public func loginKakaoAccount(completion: @escaping (Bool) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    self.getUserInfo() { success in
                        if success {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    self.getUserInfo() { success in
                        if success {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                }
            }
        }
    }
    
    private func getUserInfo(completion: @escaping (Bool) -> Void) {
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
                
                self.customer.authProvider = "KAKAO"
                
                print(self.customer)
                
                NetworkManager.shared.sendUserData(customer: customer) { result in
                    switch result {
                    case .success(let updatedCustomer):
                        self.customer.accessToken = updatedCustomer.accessToken
                        self.customer.refreshToken = updatedCustomer.refreshToken
                        completion(true)
                        print("User data sent and processed successfully")
                    case .failure(let error):
                        completion(false)
                        print("Failed to send or process user data: \(error)")
                    }
                }
            }
        }
    }
}
