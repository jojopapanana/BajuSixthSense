//
//  ProfileWardrobeView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
    @ObservedObject var wardrobeVM = WardrobeViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                NavigationLink{
                    ProfileAllCatalogueView(
                        statusText: .Draft
                    )
                } label: {
                    HStack(spacing: 10){
                        Text("Draft")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(
                        !wardrobeVM.wardrobeItems.isEmpty ? .black : .systemGrey1
                    )
                }
                
                Divider()
                
                if !wardrobeVM.wardrobeItems.isEmpty {
                    ClothesListComponentView(
                        clothData:
                            wardrobeVM.wardrobeItems.first ?? ClothEntity()
                    )
                        .padding(.bottom, 20)
                } else {
                    Text("Your draft is empty.")
                        .foregroundStyle(.systemGrey1)
                        .padding(.bottom, 150)
                }
                
                
                NavigationLink {
                    ProfileAllCatalogueView(
                        statusText: .Posted
                    )
                } label: {
                    HStack(spacing: 10){
                        Text("Posted")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(
                        !wardrobeVM.wardrobeItems.isEmpty ? .black : .systemGrey1
                    )
                }
                
                Divider()
                
                if !wardrobeVM.wardrobeItems.isEmpty {
                    ClothesListComponentView(
                        clothData: wardrobeVM.wardrobeItems[0]
                    )
                        .padding(.bottom, 15)
                    
                    Divider()
                    
                    ClothesListComponentView(
                        clothData: wardrobeVM.wardrobeItems[1]
                    )
                } else {
                    Text("Your wardrobe is empty. Your uploaded clothes will be showed here.")
                        .foregroundStyle(.systemGrey1)
                        .padding(.bottom, 300)
                }
            }
        }
    }
}

#Preview {
    ProfileWardrobeView()
}
