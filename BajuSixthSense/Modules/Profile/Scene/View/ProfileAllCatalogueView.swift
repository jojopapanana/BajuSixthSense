//
//  ProfileAllDraftView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileAllCatalogueView: View {
    var catalogueNumber:Int
    var catalogueStatus:String
    @State private var statusText = "Draft"
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(0..<catalogueNumber){ _ in
                    ClothesListComponentView(status: statusText)
                        .padding(.bottom, 20)
                        .padding(.top, 7)
                        .listRowInsets(EdgeInsets())
                        .swipeActions {
                            Button(role: .destructive) {
                                // Your delete action
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                        }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle(statusText)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear{
            switch catalogueStatus{
            case "Draft":
                statusText = "Draft"
                
            case "Posted":
                statusText = "Posted"
                
            case "Given":
                statusText = "Given"
                
            default:
                statusText = "not listed"
            }
        }
    }
}

#Preview {
    ProfileAllCatalogueView(catalogueNumber: 10, catalogueStatus: "Draft")
}
