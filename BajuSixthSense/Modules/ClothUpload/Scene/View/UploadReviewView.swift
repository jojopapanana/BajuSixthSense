//
//  SwiftUIView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/11/24.
//

import SwiftUI
import RiveRuntime

struct UploadReviewView: View {
    @State private var isButtonDisabled = false
    @ObservedObject var uploadVM = UploadClothViewModel.shared
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Review Pakaian")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 16)
                    
                    Text("Pastikan foto dan label pakaian sudah sesuai")
                        .font(.body)
                        .foregroundStyle(Color.labelSecondary2)
                    
                    if uploadVM.clothesUpload.count > 0 {
                        ForEach(uploadVM.clothesUpload, id: \.self) { cloth in
                            LongCardView(
                                cloth: cloth,
                                onDelete: {
                                    uploadVM.removeFromUpload(cloth: cloth)
                                }
                            )
                            .padding(.top, 16)
                        }
                    } else {
                        RiveViewModel(fileName:"shellyloading-4").view()
                            .frame(width: 200, height: 200)
                            .padding(.top, 16)
                    }
                }
                .frame(width: 361)
                .padding(.horizontal)
                .padding(.bottom, 64)
            }
            
            VStack {
                Spacer()
            
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(height: 88)
                    
                    Button {
                        do {
                            try uploadVM.uploadCloth()
                            navigationRouter.backToDiscovery()
                        } catch {
                            print("failed uploading clothes")
                        }
                    } label: {
                        CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Upload", isButtonDisabled: $isButtonDisabled)
                    }
                    .padding(.bottom, 8)
                }
            }
            .ignoresSafeArea()
        }
        .navigationTitle("Upload")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    UploadReviewView()
//}
