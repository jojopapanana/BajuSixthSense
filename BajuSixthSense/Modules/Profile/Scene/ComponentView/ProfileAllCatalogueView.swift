//
//  ProfileAllDraftView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileAllCatalogueView: View {
//    var catalogueNumber:Int
    var statusText: ClothStatus
    @State private var deleteAlertPresented = false
    @ObservedObject var wardrobeVM = WardrobeViewModel()
    @State var chosenID: String?
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(wardrobeVM.wardrobeItems, id:\.self) { clothItem in
                    #warning("TO-DO: make navigation link to redirect to continue the draft")
                    ClothesListComponentView(clothData: clothItem)
                        .padding(.bottom, 20)
                        .padding(.top, 7)
                        .listRowInsets(EdgeInsets())
                        .swipeActions {
                            Button{
                                deleteAlertPresented = true
                                chosenID = clothItem.id
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                            .tint(.red)
                        }
                        .alert(
                            "Are you sure to delete this catalogue?",
                            isPresented: $deleteAlertPresented
                        ){
                            Button("Yes", role: .destructive){
                                do {
                                    try wardrobeVM.removeWardrobe(id: clothItem.id)
                                } catch {
                                    print("Failed deleting wardrobe item: \(error.localizedDescription)")
                                }
                            }
                            Button("Cancel", role: .cancel){}
                        }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle(statusText.rawValue)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileAllCatalogueView(statusText: .Draft)
}
