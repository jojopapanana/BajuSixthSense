//
//  EditItemDropDownView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 08/11/24.
//

import SwiftUI

struct DropDownMenu: View {
    
    let options: [String]
    
    var menuWidth: CGFloat = 150
    var buttonHeight: CGFloat = 30
    var maxItemDisplayed: Int = 10
    var selectionSpacing: CGFloat = 8
    
    @Binding var selectedOptionIndex: Int
    @Binding var showDropdown: Bool
    @Binding var selectedDefects: [Int]
    
    @Binding var typeText: String
    @Binding var colorText: String
    @Binding var selectedDefectTexts: [String]
    
    @State private var scrollPosition: Int?
    @State var dropdownType: String
    
    var body: some  View {
        VStack {
            VStack(spacing: 0) {
                Button(action: {
                    showDropdown.toggle()
                }, label: {
                    HStack {
                        if(dropdownType == "Defects"){
                            ForEach(0..<selectedDefects.count, id: \.self){index in
                                if(index != 0){
                                    HStack{
                                        Text(options[selectedDefects[index]])
                                            .foregroundStyle(.systemPureWhite)
                                            .font(.system(size: 11))
                                        
                                        Button{
                                            selectedDefects.remove(at: index)
                                            selectedDefectTexts.remove(at: index)
                                            print("selected defect texts: \(selectedDefectTexts)")
                                        } label: {
                                            Image(systemName: "plus")
                                                .rotationEffect(.degrees(45))
                                                .font(.system(size: 11))
                                        }
                                    }
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(content: {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(.systemBlack)
                                    })
                                    .padding(.trailing, 4)
                                }
                            }
                        } else {
                            Text(dropdownType == "Type" ? typeText : colorText)
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelPrimary)
                                .padding(.leading, -8)
                        }
                        
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
                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                
                if (showDropdown) {
                    let scrollViewHeight: CGFloat  = options.count > maxItemDisplayed ? (buttonHeight*CGFloat(maxItemDisplayed)) : (buttonHeight*CGFloat(options.count))
                    
                    VStack {
                        VStack(spacing: 0) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        if(dropdownType == "Defects"){
                                            selectedDefects.append(index)
                                            selectedDefectTexts.append(options[index])
                                        } else {
                                            selectedOptionIndex = index
                                            if(dropdownType == "Type"){
                                                typeText = options[index]
                                            } else {
                                                colorText = options[index]
                                            }
                                            
                                            showDropdown.toggle()
                                        }
                                    }
                                }, label: {
                                    HStack {
                                        Text(options[index])
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                            .foregroundStyle(.labelPrimary)
                                            .padding(.leading, -8)
                                        
                                        Spacer()
                                        
                                        if (index == selectedOptionIndex || selectedDefects.contains(index)) {
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
                                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                                
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
        .frame(width: menuWidth, height: buttonHeight, alignment: .top)
    }
}

//#Preview {
//    UploadCardView()
//}
