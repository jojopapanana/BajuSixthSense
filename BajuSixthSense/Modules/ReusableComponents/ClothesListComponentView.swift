//
//  ClothesListComponentView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/10/24.
//

import SwiftUI

struct ClothesListComponentView: View {
    var status:String
    let dummy = "Draft"
    
    var body: some View {
        HStack {
            Image("bajusample")
                .resizable()
                .frame(width: 125)
                .overlay(RoundedRectangle(cornerRadius: 3.49)
                    .stroke(.black, lineWidth: 0.33)
                    .foregroundStyle(.clear))
            
            VStack(alignment: .leading) {
                Text("\(status) · September 9th 2024")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "tray")
                    Text("10 clothes")
                        .fontWeight(.semibold)
                }
                .padding(.top, 4)
                
                HStack {
                    LabelView(labelText: "Shirt", horizontalPadding: 5, verticalPadding: 3)
                    LabelView(labelText: "T-Shirt", horizontalPadding: 5, verticalPadding: 3)
                    Text("More")
                }
                
                Spacer()
                
                
                switch status {
                    case "Draft":
                        Button {
                            #warning("TO-DO: put logic for draft")
                        } label: {
                            ProfileButtonView(buttonText: "Continue")
                        }
                        
                    case "Posted":
                        Button {
                            #warning("TO-DO: put logic for posted")
                        } label: {
                            ProfileButtonView(buttonText: "Mark as Given")
                        }
                        
                    case "Given":
                        Button {
                            #warning("TO-DO: put logic for given")
                        } label: {
                            ProfileButtonView(buttonText: "Mark as Posted")
                        }
                        
                    default:
                        Text("not included in any case")
                    }
            }
            
            Spacer()
            
            if status == "Posted" {
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

#Preview {
    ClothesListComponentView(status: "Draft")
}
