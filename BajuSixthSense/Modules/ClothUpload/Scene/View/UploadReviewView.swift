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
    @ObservedObject var uploadVM: UploadClothViewModel
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(alignment: .leading){
                    Text("Review Pakaian")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 16)
                    
                    Text("Pastikan foto dan label pakaian sudah sesuai")
                        .font(.body)
                        .foregroundStyle(Color.labelSecondary2)
                    
                    if uploadVM.clothes.count > 0{
                        ForEach(uploadVM.clothes) { cloth in
                            LongCardView(
                                image: cloth.clothImage,
                                type: cloth.clothType,
                                color: cloth.clothColor,
                                defects: cloth.clothDefects ?? ["None"],
                                price: cloth.clothPrice ?? 0,
                                onDelete: {
                                    uploadVM.clothes.removeAll { $0.id == cloth.id }
                            })
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
                        #warning("TO-DO: Implement upload functionality")
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
