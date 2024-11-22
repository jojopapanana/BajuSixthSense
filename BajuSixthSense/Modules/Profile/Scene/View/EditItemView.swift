//
//  EditItemView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 09/11/24.
//

import SwiftUI

struct EditItemView: View {
    @State private var isButtonDisabled = false
    var index: Int
    var cloth: ClothEntity
    @ObservedObject var wardrobeVM: WardrobeViewModel
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Edit Pakaian")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.labelPrimary)
                .padding(.horizontal)
            
            Text("Ada yang kurang? Update lagi pakaianmu!")
                .font(.body)
                .fontWeight(.regular)
                .foregroundStyle(.labelSecondary2)
                .padding(.bottom, 16)
                .padding(.horizontal)
            
            UploadCardView(
                index: index,
                cloth: cloth,
                isUploadCardView: false
            )
            
            Spacer()
            
            HStack{
                Spacer()
                
                Button {
                    do {
                        try wardrobeVM.updateWardrobe(cloth: wardrobeVM.fetchWardrobeItems()[index])
                    } catch {
                        print("Failed saving changes")
                    }
                    navigationRouter.goBack()
                } label: {
                    CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Simpan", isButtonDisabled: $isButtonDisabled)
                }
                
                Spacer()
            }
            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    do {
                        try wardrobeVM.removeWardrobe(id: wardrobeVM.fetchWardrobeItems()[index].id)
                    } catch {
                        print("Failed removing wardrobe")
                    }
                    navigationRouter.goBack()
                } label: {
                    Text("Hapus")
                }
            }
        }
    }
}

//#Preview {
//    EditItemView()
//}
