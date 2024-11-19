//
//  UploadDetailsView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 09/11/24.
//

import SwiftUI
import RiveRuntime

struct UploadDetailsView: View {
    @State private var isButtonDisabled = false
//    @State private var navigate = false
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @ObservedObject var uploadVM = UploadClothViewModel.shared
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(alignment: .leading){
                    Text("Postingan Baru")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 16)
                    
                    Text("Posting hingga 10 pakaian")
                        .font(.body)
                        .foregroundStyle(Color.labelSecondary2)
                    
                    if uploadVM.completeProcessing {
                        ForEach(0..<uploadVM.clothesUpload.count, id: \.self) { index in
                            UploadCardView(
                                index: index, isUploadCardView: true
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
            
            VStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(.white)
                        .frame(height: 88)
                    
                    Button{
//                        self.navigate = true
                        navigationRouter.push(to: .UploadReview)
                    } label: {
                        CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Selanjutnya", isButtonDisabled: $isButtonDisabled)
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
//    UploadDetailsView()
//}
