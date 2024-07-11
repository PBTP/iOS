//
//  ProfileView.swift
//  ProfileFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

public struct ProfileView: View {
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            TabHeaderComponent(headerText: "마이", iconImageName: Image.gearIcon) { }
            
            VStack(spacing: 32) {
                PersonProfileArea()
                
                PetProfileArea()
                
                FavoriteStoreArea()
            }
            Spacer()
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ProfileView()
}
