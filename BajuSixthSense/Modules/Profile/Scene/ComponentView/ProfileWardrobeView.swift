//
//  ProfileWardrobeView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @ObservedObject var wardrobeVM = WardrobeViewModel()
    
    @State var deleteAlertPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                navigationRouter.push(to: .ProfileItemList(status: .Draft))
            } label: {
                HStack(spacing: 10){
                    Text("Draft")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(
                    !wardrobeVM.draftItems.isEmpty ? .black : .systemGrey1
                )
            }
            .disabled(wardrobeVM.draftItems.isEmpty)
            
            Divider()
            
            if !wardrobeVM.draftItems.isEmpty {
                List {
                    ClothesListComponentView(
                        clothData:
                            wardrobeVM.draftItems.first ?? ClothEntity(),
                        wardrobeVM: wardrobeVM
                    )
                    .swipeActions {
                        Button{
                            deleteAlertPresented = true
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
                    .alert(
                        "Are you sure to delete this catalogue?",
                        isPresented: $deleteAlertPresented
                    ) {
                        Button("Yes", role: .destructive) {
                            do {
                                try wardrobeVM.removeWardrobe(id: wardrobeVM.draftItems.first?.id)
                                print("Delete")
                            } catch {
                                print("Failed deleting wardrobe item: \(error.localizedDescription)")
                            }
                        }
                        
                        Button("Cancel", role: .cancel) {
                            print("Cancel")
                        }
                    }
                }
                .frame(height: 157)
                .listStyle(.plain)
                .scrollDisabled(true)
            } else {
                VStack {
                    Text("Your draft is empty.")
                        .foregroundStyle(.systemGrey1)
                    
                    Spacer()
                }
                .frame(height: 157)
            }
            
            
            Button {
                navigationRouter.push(to: .ProfileItemList(status: .Posted))
            } label: {
                HStack(spacing: 10){
                    Text("Posted")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(
                    !wardrobeVM.postedItems.isEmpty ? .black : .systemGrey1
                )
            }
            .disabled(wardrobeVM.postedItems.isEmpty)
            
            Divider()
            
            if !wardrobeVM.postedItems.isEmpty {
                List {
                    ClothesListComponentView(
                        clothData: wardrobeVM.postedItems.first ?? ClothEntity(),
                        wardrobeVM: wardrobeVM
                    )
                    .frame(height: 125)
                    .swipeActions {
                        Button{
                            deleteAlertPresented = true
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        .tint(.red)
                    }
                    .alert(
                        "Are you sure to delete this catalogue?",
                        isPresented: $deleteAlertPresented
                    ) {
                        Button("Yes", role: .destructive) {
                            do {
                                try wardrobeVM.removeWardrobe(id: wardrobeVM.postedItems.first?.id)
                                print("Delete")
                            } catch {
                                print("Failed deleting wardrobe item: \(error.localizedDescription)")
                            }
                        }
                        
                        Button("Cancel", role: .cancel) {
                            print("Cancel")
                        }
                    }
                    
                    if wardrobeVM.postedItems.count > 1 {
                        ClothesListComponentView(
                            clothData: wardrobeVM.postedItems[1],
                            wardrobeVM: wardrobeVM
                        )
                        .frame(height: 125)
                        .swipeActions {
                            Button{
                                deleteAlertPresented = true
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                            .tint(.red)
                        }
                        .alert(
                            "Are you sure to delete this catalogue?",
                            isPresented: $deleteAlertPresented
                        ) {
                            Button("Yes", role: .destructive) {
                                do {
                                    try wardrobeVM.removeWardrobe(id: wardrobeVM.postedItems[1].id)
                                    print("Delete")
                                } catch {
                                    print("Failed deleting wardrobe item: \(error.localizedDescription)")
                                }
                            }
                            
                            Button("Cancel", role: .cancel) {
                                print("Cancel")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
            } else {
                Text("Your wardrobe is empty. Your uploaded clothes will be showed here.")
                    .foregroundStyle(.systemGrey1)
                    .padding(.bottom, 300)
            }
        }
    }
}

#Preview {
    ProfileWardrobeView()
}
