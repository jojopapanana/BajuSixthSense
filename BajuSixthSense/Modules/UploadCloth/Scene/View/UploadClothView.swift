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
            ZStack {
                Color("SystemWhite")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 28) {
                        
                        UploadPictureView(vm: vm)
                            .padding(.top, 16)
                            .padding(.horizontal)
                        
                        UploadNumberOfClothesView(numberOfClothes: $numberofClothes)
                            .padding(.horizontal)
                        
                        UploadClothesTypeView(selectedClothesType: $selectedClothesType)
                            .padding(.horizontal)
                        
                        UploadAdditionalNotesView(text: $additionalText)
                            .padding(.horizontal)
                        
                    }
                    // button draft ama continue kalo gak fixed disini
                    
                    .navigationTitle("Upload")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .scrollDismissesKeyboard(.automatic)
            }
        }
        // button draft sama continue disini harusnya kalo mau fixed position
        HStack {
            Button(action: {
                vm.upload(images: vm.selectedImages, clothesType: Array(selectedClothesType), clothesQty: numberofClothes ?? 0, additionalNotes: additionalText, status: "Draft")
            }) {
                Text("Save to Draft")
                    .frame(width: 149, height: 50)
                    .background((vm.selectedImages.isEmpty && selectedClothesType.isEmpty && numberofClothes == 0) ? Color.systemGrey2 : Color.clear)
                    .foregroundColor((vm.selectedImages.isEmpty && selectedClothesType.isEmpty && numberofClothes == 0) ? Color.systemGrey1 : Color.systemPrimary)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke((vm.selectedImages.isEmpty && selectedClothesType.isEmpty && numberofClothes == 0) ? Color.systemGrey1 : Color.systemPrimary, lineWidth: 1)
                    )
            }
            .disabled(vm.selectedImages.isEmpty && selectedClothesType.isEmpty && numberofClothes == 0)
            .padding(.all, 12)
            
            Button(action: {
                vm.upload(images: vm.selectedImages, clothesType: Array(selectedClothesType), clothesQty: numberofClothes ?? 0, additionalNotes: additionalText, status: "")
            }) {
                Text("Upload")
                    .frame(width: 177, height: 50)
                    .background((vm.selectedImages.isEmpty || selectedClothesType.isEmpty || numberofClothes == 0) ? Color.systemGrey2 : Color.systemPrimary)
                    .foregroundColor(Color.systemWhite)
                    .cornerRadius(12)
            }
            .disabled(vm.selectedImages.isEmpty || selectedClothesType.isEmpty || numberofClothes == 0)
        }
    }
}

#Preview {
    UploadClothView()
}
