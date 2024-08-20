//
//  ProfileImageButton.swift
//  ProfileFeature
//
//  Created by bulmang on 7/14/24.
//  Copyright © 2024 Mongle-iOS. All rights reserved.
//

import SwiftUI
import PhotosUI
import Ui

struct ProfileImageButton: View {
    @Binding var image: UIImage?
    @State private var isPickerPresented = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSettingsAlert = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("프로필 사진")
                .font(.mgBody3)
                .foregroundColor(Color.mongleGrayScale700)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                Image.profileDefaultImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            
            Button {
                print("Profile image button clicked")
                checkPhotoLibraryPermission()
            } label: {
                Text("사진 선택")
                    .font(.mgBody3)
                    .foregroundColor(Color.mongleGrayScale400)
            }
            .buttonStyle(StrokeButtonStyle(buttonColor: Color.clear, textColor: Color.mongleGrayScale0, strokeColor: Color.mongleGrayScale300, textFont: .mgTitle2, verticalPadding: 12, horizontalPadding: 16, radius: 5, lineWidth: 1))
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(image: $image)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("허용이 필요합니다"),
                  message: Text(alertMessage),
                  primaryButton: .destructive(Text("접근 거부")),
                  secondaryButton: .default(Text("설정 변경"), action: {
                openAppSettings()
            })
            )
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized || newStatus == .limited {
                        isPickerPresented = true
                    } else {
                        alertMessage = "사진첩에 접근할 수 없습니다. 설정에서 허용해주세요."
                        showAlert = true
                    }
                }
            }
        case .authorized, .limited:
            isPickerPresented = true
        case .denied, .restricted:
            alertMessage = "사진첩에 접근할 수 없습니다. 설정에서 허용해주세요."
            showAlert = true
        @unknown default:
            alertMessage = "오류 발생하였습니다. 고개 문의 부탁드립니다."
            showAlert = true
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileImageButton(image: .constant(UIImage(named: "profileDefaultImage")))
}