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
                        .foregroundStyle(Color.systemGrey1)
                    
                    if uploadVM.clothes.count == uploadVM.fetchPhoto().count{
                        ForEach(uploadVM.clothes) { cloth in
                            HStack{
                                Image(uiImage: cloth.clothImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 114, height: 114)
                                        .padding()
                                
                                VStack(alignment: .leading){
                                    Text("\(cloth.clothColor) \(cloth.clothType)")
                                        .font(.headline)
                                        .padding()
                                    
                                    if !(cloth.clothDefects?.isEmpty ?? false){
                                        HStack{
                                            ForEach(cloth.clothDefects ?? [], id: \.self){ defect in
                                                if(defect != cloth.clothDefects?.last){
                                                    Text("\(defect) " )
                                                    Image(systemName: "circle.fill")
                                                    Text(" ")
                                                } else {
                                                    Text(defect)
                                                }
                                            }
                                        }
                                    }
                                    
                                    Text("\(cloth.clothPrice ?? 0)")
                                    Text(cloth.clothDescription ?? "No desc")
                                }
                                Spacer()
                            }
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
                .padding(.bottom, 24)
            }
//            .onAppear{
//                let images = uploadVM.fetchPhoto()
//                
//                ForEach(0..<uploadVM.fetchPhoto().count, id: \.self){ index in
//                    if let image = images[index]{
//                        let type = uploadVM.classificationResult[index]
//                        let color = uploadVM.colorClassificationResult[index]
//                        let defects = uploadVM.defects[index]
//                        let desc = uploadVM.description[index]
//                        let price = uploadVM.price[index]
//                        
//                        let cloth = ClothParameter(id: UUID().uuidString, clothImage: image, clothType: type, clothColor: color, clothDefects: defects, clothDescription: desc, clothPrice: price)
//                        
//                        uploadVM.clothes.append(cloth)
//                    }
//                }
//            }
            
            VStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(.white)
                        .frame(height: 88)
                    
//                    NavigationLink{
//                        UploadReviewView()
//                    } label: {
//                        CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Selanjutnya", isButtonDisabled: $isButtonDisabled)
//                    }
//                    .padding(.bottom, 8)
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
