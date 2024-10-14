//
//  SheetLocationOnboardingView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 14/10/24.
//

import SwiftUI

struct SheetLocationOnboardingView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 361, height: 361)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 14)
                Text("We need your permission to access location")
                    .font(.title)
                    .bold()
                    .padding(.horizontal, 16)
                    .padding(.bottom, 9)
                Text("We need your location to show how far bulk items are from you. This helps you find what’s closest, saving time and effort.")
                    .font(.subheadline)
                    .foregroundStyle(Color.systemGrey1)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                Text("Tip: Using your house location is ideal, makes it easier to find bulk items near where you are staying")
                    .font(.subheadline)
                    .foregroundStyle(Color.systemGrey1)
                    .padding(.horizontal, 16)
                Spacer()
                Button {
                    // action
                } label: {
                    Text("Allow Location Access")
                        .font(.system(size: 17))
                        .foregroundStyle(Color.systemWhite)
                        .frame(width: 360, height: 50)
                        .background(Color.systemPrimary)
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                }

            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // action
                    }, label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.systemPrimary)
                    })
                }
            }
        }
    }
}

#Preview {
    SheetLocationOnboardingView()
}
