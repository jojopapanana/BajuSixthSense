//
//  ClothesListComponentView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/10/24.
//

import SwiftUI

struct ClothesListComponentView: View {
    var clothData: ClothEntity
    var wardrobeVM = WardrobeViewModel()
    
    var body: some View {
        HStack {
            PhotoFrame(
                width: 126,
                height: 148,
                cornerRadius: 3.49,
                image: clothData.photos.first ?? nil
            )
            
            VStack(alignment: .leading) {
                Text("\(clothData.status.rawValue) · September 9th 2024")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "tray")
                    Text("10 clothes")
                        .fontWeight(.semibold)
                }
                .padding(.top, 4)
                
                HStack {
                    LabelView(labelText: "Shirt", fontType: .body, horizontalPadding: 5, verticalPadding: 3)
                    LabelView(labelText: "T-Shirt", fontType: .body, horizontalPadding: 5, verticalPadding: 3)
                    Text("More")
                }
                
                Spacer()
                
                Button {
                    do {
                        switch clothData.status {
                        case .Draft:
                        #warning("TO-DO: redirect to editing page")
                            break
                        case .Posted:
                            try wardrobeVM.updateClothStatus(
                                clothId: clothData.id,
                                status: .Given
                            )
                        case .Given:
                            try wardrobeVM.updateClothStatus(
                                clothId: clothData.id,
                                status: .Posted
                            )
                        default:
                            throw ActionFailure.FailedAction
                        }
                    } catch {
                        print("Failed action: \(error.localizedDescription)")
                    }
                } label: {
                    ProfileButtonView(
                        buttonText: clothData.status.getProfileButtonText()
                    )
                }
            }
            
            Spacer()
            
            if clothData.status == .Posted {
                VStack {
                    Button {
                        #warning("TO-DO: redirect to editing page")
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(
                                Circle()
                                    .foregroundStyle(.black)
                            )
                    }
                    
                    Spacer()
                }
            }
        }
        .frame(height: 150)
    }
}

//#Preview {
//    ClothesListComponentView()
//}
