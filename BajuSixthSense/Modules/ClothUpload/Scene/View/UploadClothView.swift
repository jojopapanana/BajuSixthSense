// 
//  UploadClothViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

enum ClothDataState {
    case Upload
    case Edit
}

struct UploadClothView: View {
    var viewState = ClothDataState.Upload
    @State private var isEditMode = false
    @ObservedObject var uploadVM: UploadClothViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.systemBGBase
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 28) {
                        UploadPictureView(uploadVM: uploadVM)
                            .padding(.top, 16)
                            .padding(.horizontal)
                        
                        UploadNumberOfClothesView(uploadVM: uploadVM)
                            .padding(.horizontal)
                        
                        UploadClothesTypeView(uploadVM: uploadVM)
                            .padding(.horizontal)
                        
                        UploadAdditionalNotesView(uploadVM: uploadVM)
                            .padding(.horizontal)
                    }
                    .navigationTitle("Upload")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .scrollDismissesKeyboard(.automatic)
            }
            
            HStack(spacing: 12){
                Button {
                    uploadVM.defaultCloth.status = .Draft
                    
                    do {
                        if viewState == .Edit {
                            try uploadVM.deleteCloth()
                        } else {
                            try uploadVM.uploadCloth()
                        }
                    } catch {
                        print("Failed to preform action: \(error.localizedDescription)")
                    }
                } label: {
                    CustomButtonView(
                        buttonType: viewState == .Edit ? ButtonType.destructive : ButtonType.secondary,
                        buttonWidth: 150,
                        buttonLabel: viewState == .Edit ? "Delete" : "Save to Draft",
                        isButtonDisabled: viewState == .Edit ? $isEditMode : $uploadVM.disableSecondary)
                }
                .disabled(uploadVM.disableSecondary)
                
                Button {
                    uploadVM.defaultCloth.status = .Posted
                    
                    do {
                        if viewState == .Edit {
                            try uploadVM.updateCloth()
                        } else {
                            try uploadVM.uploadCloth()
                        }
                    } catch {
                        print("Failed to preform action: \(error.localizedDescription)")
                    }
                } label: {
                    CustomButtonView(
                        buttonType: .primary,
                        buttonWidth: 200,
                        buttonLabel: viewState == .Edit ? "Save Changes" : "Post",
                        isButtonDisabled: viewState == .Edit ? $isEditMode : $uploadVM.disablePrimary)
                }
                .disabled(uploadVM.disablePrimary)
            }
            .padding([.top, .horizontal], 16)
        }
    }
}

#Preview {
    UploadClothView(viewState: .Edit, uploadVM: UploadClothViewModel())
}
