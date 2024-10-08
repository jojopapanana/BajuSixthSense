//
//  CustomNavigationBar.swift
//  MacroChallenge
//
//  Created by PadilKeren on 05/10/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    var body: some View {
        ZStack {
            Baloon()
                .fill(Color.blue) // You can change the color to suit your design
                .frame(height: 200) // Adjust height to your preference
                .shadow(radius: 5)
                .offset(y: -50)
                .clipped()
            
            VStack {
                Text("Custom Navigation Bar")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
            }
            .padding(.top, 50) // Adjust padding for navigation title positioning
        }
        .frame(height: 150)
        .edgesIgnoringSafeArea(.top)
    }
}
