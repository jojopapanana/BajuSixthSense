//
//  EditItemDropDownView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 08/11/24.
//

import SwiftUI

enum DropDownType {
    case Defects
    case Category
    case Color
    
    var getOptions: [String] {
        switch self {
            case .Defects:
                return ClothDefect.fetchTypesArray()
            case .Category:
                return ClothType.fetchTypesArray()
            case .Color:
                return ClothColor.fetchTypesArray()
        }
    }
}

struct DropDownMenu: View {
    var menuWidth: CGFloat = 150
    var buttonHeight: CGFloat = 30
    var maxItemDisplayed: Int = 10
    var selectionSpacing: CGFloat = 8
    
    var options: [String]
    @State var showDropdown: Bool = false
    var index: Int
//    var cloth: ClothEntity
    var dropdownType: DropDownType
    var isUpload: Bool
    
    @ObservedObject var uploadVM = UploadClothViewModel.shared
    @ObservedObject var wardrobeVM = WardrobeViewModel.shared
    
    var body: some  View {
        VStack {
            VStack(spacing: 0) {
                Button {
                    showDropdown.toggle()
                } label: {
                    if (isUpload && index < uploadVM.clothesUpload.count) || (!isUpload && index < wardrobeVM.wardrobeItems.count){
                        HStack {
                            if(dropdownType == .Defects){
                                ForEach(isUpload ? uploadVM.clothesUpload[index].defects : wardrobeVM.wardrobeItems[index].defects, id: \.self) { defect in
                                    HStack(spacing: 2){
                                        Text(defect.rawValue)
                                            .foregroundStyle(.systemPureWhite)
                                            .font(.system(size: 11))
                                        
                                        Button{
                                                if isUpload {
                                                    if let idx = uploadVM.clothesUpload[index].defects.firstIndex(of: defect){
                                                        uploadVM.clothesUpload[index].defects.remove(at: idx)
                                                    }
                                                } else {
                                                    if let idx = wardrobeVM.wardrobeItems[index].defects.firstIndex(of: defect){
                                                        wardrobeVM.wardrobeItems[index].defects.remove(at: idx)
                                                    }
                                                }
    //                                            if let chosenCloth = uploadVM.clothesUpload.firstIndex(of: cloth){
    //                                                uploadVM.clothesUpload[chosenCloth].defects.remove(at: idx)
    //                                            }
                                            
                                            
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
                                }
                            } else {
                                if isUpload{
                                    Text(dropdownType == .Category ? uploadVM.clothesUpload[index].category.getName : uploadVM.clothesUpload[index].color.getName)
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                        .foregroundStyle(.labelPrimary)
                                        .padding(.leading, -8)
                                } else {
                                    Text(dropdownType == .Category ? wardrobeVM.wardrobeItems[index].category.getName : wardrobeVM.wardrobeItems[index].color.getName)
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                        .foregroundStyle(.labelPrimary)
                                        .padding(.leading, -8)
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                                .font(.caption2)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelPrimary)
                                .padding(.trailing, -8)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                
                if (showDropdown) {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(options, id: \.self) { option in
                                Button {
                                    withAnimation {
                                        if (isUpload && index < uploadVM.clothesUpload.count) || (!isUpload && index < wardrobeVM.wardrobeItems.count) {
                                            if dropdownType == .Defects {
                                                let defect = ClothDefect.assignType(type: option)
    //                                            if !uploadVM.clothesUpload[index].defects.contains(defect) {
    //                                                if isUpload{
    //                                                    if let chosenCloth = uploadVM.clothesUpload.firstIndex(of: cloth){
    //                                                        uploadVM.clothesUpload[chosenCloth].defects.append(defect)
    //                                                    }
    //                                                } else {
    //                                                    if let chosenCloth = wardrobeVM.wardrobeItems.firstIndex(of: cloth){
    //                                                        wardrobeVM.wardrobeItems[chosenCloth].defects.append(defect)
    //                                                    }
    //                                                }
    //                                            }
                                                
                                                if isUpload {
                                                    if !uploadVM.clothesUpload[index].defects.contains(defect) {
                                                        uploadVM.clothesUpload[index].defects.append(defect)
                                                    }
                                                } else {
                                                    if !wardrobeVM.wardrobeItems[index].defects.contains(defect) {
                                                        wardrobeVM.wardrobeItems[index].defects.append(defect)
                                                    }
                                                }
                                            } else {
                                                if dropdownType == .Category {
    //                                                if isUpload{
    //                                                    if let chosenCloth = uploadVM.clothesUpload.firstIndex(of: cloth){
    //                                                        uploadVM.clothesUpload[chosenCloth].category = ClothType.assignType(type: option)
    //                                                    }
    //                                                } else {
    //                                                    if let chosenCloth = wardrobeVM.wardrobeItems.firstIndex(of: cloth){
    //                                                        wardrobeVM.wardrobeItems[chosenCloth].category = ClothType.assignType(type: option)
    //                                                    }
    //                                                }
                                                    
                                                    if isUpload {
                                                        uploadVM.clothesUpload[index].category = ClothType.assignType(type: option)
                                                    } else {
                                                        wardrobeVM.wardrobeItems[index].category = ClothType.assignType(type: option)
                                                    }
                                                } else {
    //                                                if isUpload{
    //                                                    if let chosenCloth = uploadVM.clothesUpload.firstIndex(of: cloth){
    //                                                        uploadVM.clothesUpload[chosenCloth].color = ClothColor.assignType(type: option)
    //                                                    }
    //                                                } else {
    //                                                    if let chosenCloth = wardrobeVM.wardrobeItems.firstIndex(of: cloth){
    //                                                        wardrobeVM.wardrobeItems[chosenCloth].color = ClothColor.assignType(type: option)
    //                                                    }
    //                                                }
                                                    
                                                    if isUpload {
                                                        uploadVM.clothesUpload[index].color = ClothColor.assignType(type: option)
                                                    } else {
                                                        wardrobeVM.wardrobeItems[index].color = ClothColor.assignType(type: option)
                                                    }
                                                }
                                                showDropdown.toggle()
                                            }
                                        }
                                        
                                    }
                                } label: {
                                    HStack {
                                        switch dropdownType {
                                            case .Category:
                                            Text(ClothType.assignType(type: option).getName)
                                                .font(.subheadline)
                                                .fontWeight(.regular)
                                                .foregroundStyle(.labelPrimary)
                                                .padding(.leading, -8)
                                        case .Color:
                                            Text(ClothColor.assignType(type: option).getName)
                                                .font(.subheadline)
                                                .fontWeight(.regular)
                                                .foregroundStyle(.labelPrimary)
                                                .padding(.leading, -8)
                                        case .Defects:
                                            Text(option)
                                                .font(.subheadline)
                                                .fontWeight(.regular)
                                                .foregroundStyle(.labelPrimary)
                                                .padding(.leading, -8)
                                        }
                                        
                                        Spacer()
                                        
                                        HStack {
                                            if ((dropdownType == .Defects) && checkDefects(option: option)) {
                                                Image(systemName: "checkmark")
                                            } else if ((dropdownType == .Category) && checkType(option: option)) {
                                                Image(systemName: "checkmark")
                                            } else if ((dropdownType == .Color) && checkColor(option: option)) {
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                        .foregroundStyle(.labelPrimary)
                                        .padding(.trailing, -8)
                                    }
                                    .background(
                                        .systemPureWhite
                                    )
                                }
                                .padding(.horizontal, 20)
                                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                                
                                Divider()
                                    .foregroundStyle(.systemBlack)
                            }
                        }
                    }
                    .frame(height: dropdownType == .Defects ? 100 : 200)
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
    
    private func checkDefects(option: String) -> Bool {
        if (isUpload && index < uploadVM.clothesUpload.count) || (!isUpload && index < wardrobeVM.wardrobeItems.count){
            if isUpload {
                return uploadVM.clothesUpload[index].defects.contains(ClothDefect.assignType(type: option))
    //            if let chosenCloth = uploadVM.clothesUpload.firstIndex(of: cloth){
    //                return uploadVM.clothesUpload[chosenCloth].defects.contains(ClothDefect.assignType(type: option))
    //            }
            } else {
                return wardrobeVM.wardrobeItems[index].defects.contains(ClothDefect.assignType(type: option))
    //            if let chosenCloth = wardrobeVM.wardrobeItems.firstIndex(of: cloth){
    //                return wardrobeVM.wardrobeItems[chosenCloth].defects.contains(ClothDefect.assignType(type: option))
    //            }
            }
        }
        return false
    }
    
    private func checkType(option: String) -> Bool {
        if (isUpload && index < uploadVM.clothesUpload.count) || (!isUpload && index < wardrobeVM.wardrobeItems.count){
            if isUpload {
                return option == uploadVM.clothesUpload[index].category.getName
    //            if let chosenCloth = uploadVM.clothesUpload.firstIndex(of: cloth){
    //                return option == uploadVM.clothesUpload[chosenCloth].category.getName
    //            }
            } else {
                return option == wardrobeVM.wardrobeItems[index].category.getName
    //            if let chosenCloth = wardrobeVM.wardrobeItems.firstIndex(of: cloth){
    //                return option == wardrobeVM.wardrobeItems[chosenCloth].category.getName
    //            }
            }
        }
        return false
    }
    
    private func checkColor(option: String) -> Bool {
        if (isUpload && index < uploadVM.clothesUpload.count) || (!isUpload && index < wardrobeVM.wardrobeItems.count){
            if isUpload {
                return option == uploadVM.clothesUpload[index].color.getName
    //            if let chosenCloth = uploadVM.clothesUpload.firstIndex(of: cloth){
    //                return option == uploadVM.clothesUpload[chosenCloth].color.getName
    //            }
            } else {
                return option == wardrobeVM.wardrobeItems[index].color.getName
    //            if let chosenCloth = wardrobeVM.wardrobeItems.firstIndex(of: cloth){
    //                return option == wardrobeVM.wardrobeItems[chosenCloth].color.getName
    //            }
            }
        }
        
        return false
    }
}

//#Preview {
//    UploadCardView()
//}
