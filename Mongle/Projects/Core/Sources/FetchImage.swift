//
//  FetchImage.swift
//  Core
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Foundation

struct DogImageResponse: Codable {
    let message: String
    let status: String
}

public func fetchDogImage(completion: @escaping (String?) -> Void) {
    guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            print("Failed to fetch data: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }
        
        if let decodedResponse = try? JSONDecoder().decode(DogImageResponse.self, from: data) {
            DispatchQueue.main.async {
                completion(decodedResponse.message)
            }
        } else {
            print("Failed to decode JSON")
            completion(nil)
        }
    }.resume()
}


