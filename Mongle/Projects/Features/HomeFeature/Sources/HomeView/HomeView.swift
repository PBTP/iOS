//
//  HomeView.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import Ui

public struct HomeView: View {
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            TabHeaderComponent(headerText: "홈", iconImageName: Image.bellIcon) {
                
            }
            .overlay(alignment: .trailing) {
                searchIconButton()
            }
            .padding(.horizontal, 20)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 18) {
                    Group {
                        AdBannerArea()
                        
                        LocationDateArea()
                        
                        FilterListArea()
                        
                        CompanyList()
                        
                    }
                    .padding(.horizontal, 20)
                    MongleInfoArea()
                }
            }
        }
    }
    
    @ViewBuilder
    fileprivate func searchIconButton() -> some View {
        Button {
            
        } label: {
            Image.searchGrayIcon
        }
        .padding(.trailing, 40)
    }
}

#Preview {
    HomeView()
}
