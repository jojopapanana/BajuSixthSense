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
    @State private var deleteAlertPresented = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(0..<catalogueNumber){ _ in
                    #warning("TO-DO: make navigation link to redirect to continue the draft")
                    
                    ClothesListComponentView(status: statusText)
                        .padding(.bottom, 20)
                        .padding(.top, 7)
                        .listRowInsets(EdgeInsets())
                        .swipeActions {
                            Button{
                                deleteAlertPresented = true
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                            .tint(.red)
                        }
                }
                .alert("Are you sure to delete this catalogue?", isPresented: $deleteAlertPresented){
                    Button("Yes", role: .destructive){
                        #warning("TO-DO: implement delete clothes here")
                    }
                    Button("Cancel", role: .cancel){}
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
