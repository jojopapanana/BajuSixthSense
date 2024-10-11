// 
//  UploadClothViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct UploadClothView: View {
    @State var selectedClothesType: Set<String> = []
    @State var additionalText: String = ""
    @State var numberofClothes: Int? = 0
    @StateObject private var vm = UploadClothViewModel(usecase: DefaultUploadClothUseCase(repository: DefaultUploadClothRepository()))
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    UploadPictureView(vm: vm)
                        .padding(.top, 16)
                        .padding(.horizontal)
//                        .padding(.bottom, 24)
                    
                    UploadNumberOfClothesView(numberOfClothes: $numberofClothes)
                        .padding(.horizontal)
//                        .padding(.bottom, 24)
                    
                    UploadClothesTypeView(selectedClothesType: $selectedClothesType)
                        .padding(.horizontal)
//                        .padding(.bottom, 24)
                    
                    UploadAdditionalNotesView(text: $additionalText)
                        .padding(.horizontal)
//                        .padding(.bottom, 24)
                    
                }
                // button draft ama continue kalo gak fixed disini
                
                .navigationTitle("Upload")
                .navigationBarTitleDisplayMode(.inline)
            }
            .scrollDismissesKeyboard(.automatic)
        }
        // button draft sama continue disini harusnya kalo mau fixed position
        HStack {
            Button(action: {
                vm.upload(images: vm.selectedImages, clothesType: Array(selectedClothesType), clothesQty: numberofClothes ?? 0, additionalNotes: additionalText, status: "Draft")
            }) {
                Text("Draft")
                    .frame(width: 120, height: 50)
                    .background((vm.selectedImages.isEmpty && selectedClothesType.isEmpty && numberofClothes == 0) ? Color.gray : Color.clear)
                    .foregroundColor((vm.selectedImages.isEmpty && selectedClothesType.isEmpty && numberofClothes == 0) ? Color.white : Color.black)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke((vm.selectedImages.isEmpty && selectedClothesType.isEmpty && numberofClothes == 0) ? Color.gray : Color.black, lineWidth: 1)
                    )
            }
            .disabled(vm.selectedImages.isEmpty && selectedClothesType.isEmpty && numberofClothes == 0)
            .padding(.all, 12)
            
            Button(action: {
                vm.upload(images: vm.selectedImages, clothesType: Array(selectedClothesType), clothesQty: numberofClothes ?? 0, additionalNotes: additionalText, status: "")
            }) {
                Text("Upload")
                    .frame(width: 220, height: 50)
                    .background((vm.selectedImages.isEmpty || selectedClothesType.isEmpty || numberofClothes == 0) ? Color.gray : Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
            }
            .disabled(vm.selectedImages.isEmpty || selectedClothesType.isEmpty || numberofClothes == 0)
        }
    }
}

#Preview {
    UploadClothView()
}
