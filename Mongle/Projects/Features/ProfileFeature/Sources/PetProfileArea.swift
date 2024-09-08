//
//  PetProfileArea.swift
//  ProfileFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

struct PetProfileArea: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 6) {
                Text("반려 동물")
                    .font(.mgTitle1)
                    .foregroundStyle(.black)
                
                Text("2")
                    .font(.mgTitle3)
                    .foregroundStyle(Color.mongleGrayScale500)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image.plucIcon
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            PetList()
            
            PetList()
        }
    }
}

#Preview {
    PetProfileArea()
}
