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
    @State private var navigate = false
    
    @ObservedObject var uploadVM: UploadClothViewModel
    
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
                    
                    if uploadVM.isClassificationComplete {
                        let images = uploadVM.fetchPhoto()
                        
                        ForEach(0..<uploadVM.fetchPhoto().count, id: \.self) { index in
                            if let image = images[index]{
                                UploadCardView(typeText: $uploadVM.classificationResult[index], colorText: $uploadVM.colorClassificationResult[index], defectText: $uploadVM.defects[index], descriptionText: $uploadVM.description[index], clothPrice: $uploadVM.price[index], image: image, isUploadCardView: true)
                                .padding(.top, 16)
                            }
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
            .onAppear{
                uploadVM.classifyCloth(uploadVM.fetchPhoto())
            }
            
            VStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(.white)
                        .frame(height: 88)
                    
                    Button{
                        appendClothesToViewModel()
                        self.navigate = true
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
        .navigationDestination(isPresented: $navigate){
            UploadReviewView(uploadVM: uploadVM)
        }
    }
    
    private func appendClothesToViewModel() {
        for index in 0..<uploadVM.fetchPhoto().count {
            if let image = uploadVM.fetchPhoto()[index] {
                let cloth = ClothParameter(
                    id: UUID().uuidString,
                    clothImage: image,
                    clothType: uploadVM.classificationResult[index],
                    clothColor: uploadVM.colorClassificationResult[index],
                    clothDefects: uploadVM.defects[index],
                    clothDescription: uploadVM.description[index],
                    clothPrice: uploadVM.price[index]
                )
                
                uploadVM.clothes.append(cloth)
            }
        }
    }
}

//#Preview {
//    UploadDetailsView()
//}
