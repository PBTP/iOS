//
//  CustomerDTO.swift
//  Core
//
//  Created by Bokyung on 1/25/25.
//  Copyright © 2025 Mongle. All rights reserved.
//

import Foundation

public struct CustomerDTO: Decodable {
    public let authProvider: String
    public let userType: String
    public let userId: Int
    public let phoneNumber: String
    public let uuid: String
    public let name: String
    public let accessToken: String
    public let refreshToken: String

}

/**
 {
   "authProvider": "string",
   "userType": "string",
   "userId": 0,
   "phoneNumber": "string",
   "uuid": "string",
   "name": "string",
   "accessToken": "string",
   "refreshToken": "string"
 }
 */
