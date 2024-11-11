//
//  EditItemView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 09/11/24.
//

import SwiftUI

struct EditItemView: View {
    @State private var isButtonDisabled = false
    
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
            
            #warning("TO-DO: This is the view for editing, please fill in once the cloth entity can be passed, thanks :D")
//            UploadCardView(typeText: <#T##Binding<String>#>, colorText: <#T##Binding<String>#>, defectText: <#T##Binding<[String]>#>, descriptionText: <#T##Binding<String>#>, clothPrice: <#T##Binding<Int>#>, image: <#T##UIImage#>, isUploadCardView: false)
            
            Spacer()
            
            Button {
                #warning("TO-DO: Implement save item update here")
                // save button
            } label: {
                CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Simpan", isButtonDisabled: $isButtonDisabled)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                #warning("TO-DO: Implement delete item here")
                    // action hapus
                } label: {
                    Text("Hapus")
                }
            }
        }
    }
}

#Preview {
    EditItemView()
}
