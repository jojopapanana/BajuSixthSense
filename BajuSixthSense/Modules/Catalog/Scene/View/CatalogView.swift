// 
//  CatalogViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct CatalogView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Balloon()
                        .frame(height: 200)
                    Text("CatalogView")
                }
            }
        }
        .navigationTitle("Upload")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CatalogView()
}
