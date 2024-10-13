//
//  ProfileWardrobeView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
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
                    .foregroundStyle(.black)
                }
                
                Divider()
                ClothesListComponentView(status: "Draft")
                    .padding(.bottom, 20)
                
                HStack(spacing: 10){
                    Text("Posted")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Image(systemName: "chevron.right")
                }
                
                Divider()
                ClothesListComponentView(status: "Posted")
                    .padding(.bottom, 15)
                Divider()
                ClothesListComponentView(status: "Posted")
            }
        }
    }
}

#Preview {
    ProfileWardrobeView()
}
