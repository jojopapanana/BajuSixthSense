//
//  ProfileWardrobeView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
//    @EnvironmentObject var navigationRouter: NavigationRouter
//    @ObservedObject var wardrobeVM = WardrobeViewModel()
//    
//    @State var deleteAlertPresented = false
//    @State var intendedForDeletion = ClothEntity()
    
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(0), spacing: 188, alignment: .center), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout, spacing: 16) {
                ForEach(0...5, id: \.self) { _ in
                    AllCardView(variantType: .wardrobePage)
                        .padding(.horizontal, 2)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ProfileWardrobeView()
}
