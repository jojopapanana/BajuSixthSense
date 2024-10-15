//
//  ProfileWardrobeView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
    @State private var clothesNotEmpty = true
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                NavigationLink{
                    ProfileAllCatalogueView(catalogueNumber: 10, catalogueStatus: "Draft")
                } label: {
                    HStack(spacing: 10){
                        Text("Draft")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(clothesNotEmpty ? .black : .systemGrey1)
                }
                
                Divider()
                
                if clothesNotEmpty{
                    ClothesListComponentView(status: "Draft")
                        .padding(.bottom, 20)
                } else {
                    Text("Your draft is empty.")
                        .foregroundStyle(.systemGrey1)
                        .padding(.bottom, 150)
                }
                
                
                NavigationLink{
                    ProfileAllCatalogueView(catalogueNumber: 10, catalogueStatus: "Posted")
                } label: {
                    HStack(spacing: 10){
                        Text("Posted")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(clothesNotEmpty ? .black : .systemGrey1)
                }
                
                Divider()
                
                if clothesNotEmpty{
                    ClothesListComponentView(status: "Posted")
                        .padding(.bottom, 15)
                    
                    Divider()
                    
                    ClothesListComponentView(status: "Posted")
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
