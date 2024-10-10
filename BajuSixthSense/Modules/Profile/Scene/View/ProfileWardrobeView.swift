//
//  ProfileWardrobeView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 10){
                Text("Draft")
                    .font(.headline)
                    .fontWeight(.semibold)
                Image(systemName: "chevron.right")
            }
            
            ClothesListComponentView(status: "Draft")
                .padding(.bottom, 20)
            
            HStack(spacing: 10){
                Text("Posted")
                    .font(.headline)
                    .fontWeight(.semibold)
                Image(systemName: "chevron.right")
            }
            
            ClothesListComponentView(status: "Posted")
                .padding(.bottom, 15)
            ClothesListComponentView(status: "Posted")
        }
    }
}

#Preview {
    ProfileWardrobeView()
}
