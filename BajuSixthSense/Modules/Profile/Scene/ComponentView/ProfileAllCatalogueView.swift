//
//  ProfileAllDraftView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

#warning("Deprecated")
struct ProfileAllCatalogueView: View {
    var statusText: ClothStatus
    @ObservedObject var wardrobeVM = WardrobeViewModel()
    @EnvironmentObject var navigationRouter: NavigationRouter

    @State private var deleteAlertPresented = false
    @State private var intendedForDeletion = ClothEntity()
    
    var body: some View {
        List {
            ForEach(wardrobeVM.getItems(status: statusText), id:\.self) { clothItem in
                ClothesListComponentView(clothData: clothItem, wardrobeVM: wardrobeVM)
                    .padding(.bottom, 20)
                    .padding(.top, 7)
                    .listRowInsets(EdgeInsets())
                    .swipeActions {
                        Button {
                            intendedForDeletion = clothItem
                            print(intendedForDeletion.id ?? "nil")
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
                                print(intendedForDeletion.id ?? "nil")
                                try wardrobeVM.removeWardrobe(id: intendedForDeletion.id)
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
