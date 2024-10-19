//
//  ProfileAllDraftView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileAllCatalogueView: View {
    var statusText: ClothStatus
    @ObservedObject var wardrobeVM = WardrobeViewModel()

    @State private var deleteAlertPresented = false
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        List {
            ForEach(wardrobeVM.getItems(status: statusText), id:\.self) { clothItem in
                ClothesListComponentView(clothData: clothItem, wardrobeVM: wardrobeVM)
                    .padding(.bottom, 20)
                    .padding(.top, 7)
                    .listRowInsets(EdgeInsets())
                    .swipeActions {
                        Button {
                            print(clothItem.id ?? "nil")
                            deleteAlertPresented = true
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
                    .alert(
                        "Are you sure to delete this catalogue?",
                        isPresented: $deleteAlertPresented
                    ){
                        Button("Yes", role: .destructive) {
                            do {
                                print(clothItem.id ?? "nil")
                                try wardrobeVM.removeWardrobe(id: clothItem.id)
                                navigationRouter.goBack()
                                print("Delete")
                            } catch {
                                print("Failed deleting wardrobe item: \(error.localizedDescription)")
                            }
                        }
                        
                        Button("Cancel", role: .cancel) {
                            print("Cancel")
                            navigationRouter.goBack()
                        }
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(statusText.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    ProfileAllCatalogueView(statusText: .Draft)
//}
