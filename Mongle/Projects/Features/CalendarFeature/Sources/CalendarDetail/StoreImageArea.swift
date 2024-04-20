//
//  StoreImageArea.swift
//  CalendarFeature
//
//  Created by bulmang on 4/20/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI

struct StoreImageArea: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://images.dog.ceo/breeds/akita/Akita_Inu_dog.jpg")) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(height: 212)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    StoreImageArea()
}
