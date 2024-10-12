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
    @State private var isDraftButtonDisabled = true
    @State private var isUploadButtonDisabled = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundWhite
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
                    .navigationTitle("Upload")
                    .navigationBarTitleDisplayMode(.inline)
                    .onChange(of: vm.selectedImages) { _, _ in
                        updateButtonStates()
                    }
                    .onChange(of: numberofClothes) { _, _ in
                        updateButtonStates()
                    }
                    .onChange(of: selectedClothesType) { _, _ in
                        updateButtonStates()
                    }
                }
                .scrollDismissesKeyboard(.automatic)
            }
            
            HStack(spacing: 12){
                Button(action: {
                    vm.upload(images: vm.selectedImages, clothesType: Array(selectedClothesType), clothesQty: numberofClothes ?? 0, additionalNotes: additionalText, status: "Draft")
                }) {
                    CustomButtonView(buttonType: .secondary, buttonWidth: 150, buttonLabel: "Save to Draft", isButtonDisabled: $isDraftButtonDisabled)
                }
                .disabled(isDraftButtonDisabled)
                
                Button(action: {
                    vm.upload(images: vm.selectedImages, clothesType: Array(selectedClothesType), clothesQty: numberofClothes ?? 0, additionalNotes: additionalText, status: "")
                }) {
                    CustomButtonView(buttonType: .primary, buttonWidth: 200, buttonLabel: "Post", isButtonDisabled: $isUploadButtonDisabled)
                }
                .disabled(isUploadButtonDisabled)
            }
            .padding([.top, .horizontal], 16)
        }
    }
    
    private func updateButtonStates() {
        let hasRequiredFields = !vm.selectedImages.isEmpty && !selectedClothesType.isEmpty && numberofClothes != 0
        let hasAnyFieldFilled = !vm.selectedImages.isEmpty || !selectedClothesType.isEmpty || numberofClothes != 0
        
        isUploadButtonDisabled = !hasRequiredFields
        isDraftButtonDisabled = !hasAnyFieldFilled
    }
}

#Preview {
    UploadClothView()
}
