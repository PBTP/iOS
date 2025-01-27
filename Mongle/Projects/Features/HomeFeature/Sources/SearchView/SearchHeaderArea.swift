//
//  SearchHeaderComponent.swift
//  HomeFeature
//
//  Created by bulmang on 5/1/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import UI

struct SearchHeaderArea: View {
    @Environment(\.presentationMode) var presentationMode
    @State var storeName = ""

    var body: some View {
        HStack(spacing: 17) {
            backButton
            searchTextField
        }
        .padding(.bottom, 16)
    }

    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image.arrowLeftIcon
        }
    }

    private var searchTextField: some View {
        MongleNumberTextField(text: $storeName, placeHolder: "업체명을 입력하세요", leadingPadding: 17, verticalPadding: 15)
    }
}

#Preview {
    SearchHeaderArea()
}
