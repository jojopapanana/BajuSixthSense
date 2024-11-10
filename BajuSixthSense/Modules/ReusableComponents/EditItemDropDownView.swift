//
//  EditItemDropDownView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 08/11/24.
//

import SwiftUI

struct  DropDownMenu: View {
    
    let options: [String]
    
    var menuWdith: CGFloat  =  150
    var buttonHeight: CGFloat  =  30
    var maxItemDisplayed: Int  =  10
    var selectionSpacing: CGFloat = 8
    
    @Binding  var selectedOptionIndex: Int
    @Binding  var showDropdown: Bool
    
    @State  private  var scrollPosition: Int?
    
    var body: some  View {
        VStack {
            VStack(spacing: 0) {
                // selected item
                Button(action: {
                        showDropdown.toggle()
                }, label: {
                    HStack {
                        Text(options[selectedOptionIndex])
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundStyle(.labelPrimary)
                            .padding(.leading, -8)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundStyle(.labelPrimary)
                            .padding(.trailing, -8)
                    }
                })
                .padding(.horizontal, 20)
                .frame(width: menuWdith, height: buttonHeight, alignment: .leading)
                
                // selection menu
                if (showDropdown) {
                    let scrollViewHeight: CGFloat  = options.count > maxItemDisplayed ? (buttonHeight*CGFloat(maxItemDisplayed)) : (buttonHeight*CGFloat(options.count))
                    
                    VStack {
                        VStack(spacing: 0) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        selectedOptionIndex = index
                                        showDropdown.toggle()
                                    }
                                    
                                }, label: {
                                    HStack {
                                        Text(options[index])
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                            .foregroundStyle(.labelPrimary)
                                            .padding(.leading, -8)
                                        
                                        Spacer()
                                        
                                        if (index == selectedOptionIndex) {
                                            Image(systemName: "checkmark")
                                                .font(.subheadline)
                                                .fontWeight(.regular)
                                                .foregroundStyle(.labelPrimary)
                                                .padding(.trailing, -8)
                                            
                                        }
                                    }
                                    .background(
                                        .systemPureWhite
                                    )
                                    
                                })
                                .padding(.horizontal, 20)
                                .frame(width: menuWdith, height: buttonHeight, alignment: .leading)
                                
                                if index < options.count - 1 {
                                    Divider()
                                        .foregroundStyle(.systemBlack)
                                }
                            }
                        }
                    }
                    .frame(height: scrollViewHeight)
                }
            }
            .foregroundStyle(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(.systemPureWhite)
                    .stroke(.systemBlack, lineWidth: 1)
            )
            
        }
        .frame(width: menuWdith, height: buttonHeight, alignment: .top)
    }
}

#Preview {
    UploadCardView()
}
