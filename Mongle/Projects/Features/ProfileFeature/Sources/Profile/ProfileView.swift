//
//  ProfileView.swift
//  ProfileFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import Core
import SwiftUI
import Ui

public struct ProfileView: View {
    @EnvironmentObject var kakaoAuth: KaKaoAuthCore
    public init() {}
    
    
    @State private var image: UIImage?
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TabHeaderComponent(headerText: "마이 프로필", iconImageName: Image.gearIcon) { }
                    .padding(.horizontal, 20)
                
                VStack(spacing: 32) {
                   
                    PersonProfileArea(image: $image)
                        .padding(.horizontal, 20)
                    
                    Rectangle()
                        .fill(Color.mongleGrayScale100)
                        .frame(height: 8)
                    
                    PetProfileArea()
                        .padding(.horizontal, 20)
                    
                    Rectangle()
                        .fill(Color.mongleGrayScale100)
                        .frame(height: 8)
                    
                    FavoriteStoreArea()
                        .padding(.horizontal, 20)
                }
                Spacer()
                
            }
        }
        .onAppear {
            kakaoAuth.tempLocation = nil
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(KaKaoAuthCore())
    }
}
