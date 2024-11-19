// 
//  UploadClothViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

#warning("Deprecated")
//enum ClothDataState {
//    case Upload
//    case Edit
//}

//struct UploadClothView: View {
//    var viewState = ClothDataState.Upload
//    @State private var isEditMode = false
//    @State var disablePrimary = true
//    @State var disableSecondary = true
//    
//    @EnvironmentObject private var navigationRouter: NavigationRouter
//    @ObservedObject var uploadVM: UploadClothViewModel
//    
//    var body: some View {
//        VStack {
//            ZStack {
////                Color.backgroundSystem
////                    .ignoresSafeArea()
//                
//                ScrollView {
//                    VStack(spacing: 28) {
//                        UploadPictureView(uploadVM: uploadVM)
//                            .padding(.top, 16)
//                            .padding(.horizontal)
//                        
//                        UploadNumberOfClothesView(uploadVM: uploadVM)
//                            .padding(.horizontal)
//                        
//                        UploadClothesTypeView(uploadVM: uploadVM)
//                            .padding(.horizontal)
//                        
//                        UploadAdditionalNotesView(uploadVM: uploadVM)
//                            .padding(.horizontal)
//                    }
//                    .navigationTitle("Upload")
//                    .navigationBarTitleDisplayMode(.inline)
//                }
//                .scrollDismissesKeyboard(.automatic)
//            }
//            
//            HStack(spacing: 12){
//                Button {
//                    uploadVM.defaultCloth.status = .Draft
//                    
//                    do {
//                        if viewState == .Edit {
//                            try uploadVM.deleteCloth()
//                            navigationRouter.goBack()
//                        } else {
//                            if uploadVM.defaultCloth.id == nil {
//                                try uploadVM.uploadCloth()
//                            } else {
//                                try uploadVM.updateCloth()
//                            }
//                            navigationRouter.goBack()
//                            navigationRouter.push(to: .Profile(items: nil))
//                        }
//                    } catch {
//                        print("Failed to preform action: \(error.localizedDescription)")
//                    }
//                } label: {
//                    CustomButtonView(
//                        buttonType: viewState == .Edit ? ButtonType.destructive : ButtonType.secondary,
//                        buttonWidth: 150,
//                        buttonLabel: viewState == .Edit ? "Delete" : "Save to Draft",
//                        isButtonDisabled: viewState == .Edit ? $isEditMode : $disableSecondary)
//                }
//                .disabled(uploadVM.disableSecondary)
//                .onChange(of: uploadVM.disableSecondary) { oldValue, newValue in
//                    disableSecondary = uploadVM.disableSecondary
//                }
//                
//                Button {
//                    uploadVM.defaultCloth.status = .Posted
//                    
//                    do {
//                        if viewState == .Edit {
//                            try uploadVM.updateCloth()
//                            navigationRouter.goBack()
//                        } else {
//                            if uploadVM.defaultCloth.id == nil {
//                                try uploadVM.uploadCloth()
//                            } else {
//                                try uploadVM.updateCloth()
//                            }
//                            navigationRouter.goBack()
//                            navigationRouter.push(to: .Profile(items: nil))
//                        }
//                    } catch {
//                        print("Failed to preform action: \(error.localizedDescription)")
//                    }
//                } label: {
//                    CustomButtonView(
//                        buttonType: .primary,
//                        buttonWidth: 200,
//                        buttonLabel: viewState == .Edit ? "Save Changes" : "Post",
//                        isButtonDisabled: viewState == .Edit ? $isEditMode : $disablePrimary)
//                }
//                .disabled(uploadVM.disablePrimary)
//                .onChange(of: uploadVM.disablePrimary) { oldValue, newValue in
//                    disablePrimary = uploadVM.disablePrimary
//                }
//            }
//            .padding([.top, .horizontal], 16)
//        }
//        .navigationTitle("Upload")
//    }
//}

//#Preview {
//    UploadClothView(viewState: .Edit)
//}
