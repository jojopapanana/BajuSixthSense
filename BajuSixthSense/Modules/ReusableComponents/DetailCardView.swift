//
//  DetailCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 09/11/24.
//

import SwiftUI

struct DetailCardView: View {
    @State var bookmarkClicked: Bool = false
    @State var addClicked:Bool = false
    
    var cloth: ClothEntity
    
    enum VariantType {
        case selection
        case edit
    }
    
    enum DescType {
        case descON
        case descOFF
    }
    
    var variantType: VariantType
    var descType: DescType
    
    private var rectangleHeight: CGFloat {
        switch descType {
        case .descON:
            return 562
            
        case .descOFF:
            return 498
        }
    }
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        Rectangle()
            .frame(width: 361, height: rectangleHeight)
            .foregroundStyle(.systemPureWhite)
            .cornerRadius(6)
            .overlay(
                VStack {
                    ZStack {
                        Image(uiImage: cloth.photo ?? UIImage(systemName: "exclamationmark.triangle.fill")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 361, height: 361)
                            .aspectRatio(contentMode: .fill)
                        
                        
                        switch variantType {
                        case .selection:
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        bookmarkClicked.toggle()
                                        // logic bookmark
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 38, height: 38)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 19)
                                                        .stroke(Color.systemBlack, lineWidth: 1.5)
                                                )
                                            
                                            if !bookmarkClicked{
                                                Image(systemName: "heart")
                                                    .font(.system(size: 20))
                                            } else {
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 20))
                                            }
                                        }
                                        .foregroundStyle(.systemBlack)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.top, 12)
                            .padding(.trailing, 15)
                            
                        case .edit:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(cloth.generateClothName())
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.systemBlack)
                                .padding(.top, -4)
                            
                            Spacer()
                            
                            Text(cloth.generatePriceString())
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.systemBlack)
                        }
                        .padding(.bottom, 2)
                        
                        Text(cloth.generateAllDefects())
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.labelSecondary)
                            .padding(.bottom, 12)
                        
                        switch descType {
                        case .descON:
                            Text(cloth.description)
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelSecondary)
                                .frame(height: 44)
                                .padding(.bottom, 4)
                            
                        case .descOFF:
                            EmptyView()
                        }
                        
                        Spacer()
                        
                        HStack {
                            #warning("This should be a sharelink i think")
                            Button {
                                #warning("TO-DO: Implement sharing functionality")
                            } label: {
                                Rectangle()
                                    .frame(width: 165.5, height: 50)
                                    .foregroundStyle(.systemPureWhite)
                                    .cornerRadius(6)
                                    .overlay(
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.systemBlack, lineWidth: 1)
                                            HStack {
                                                Image(systemName: "square.and.arrow.up")
                                                    .font(.body)
                                                    .fontWeight(.regular)
                                                    .foregroundStyle(.systemBlack)
                                                
                                                Text("Bagikan")
                                                    .font(.body)
                                                    .fontWeight(.regular)
                                                    .foregroundStyle(.systemBlack)
                                            }
                                        }
                                    )
                            }
                            
                            Spacer()
                            
                            switch variantType {
                            case .selection:
                                Button {
                                    #warning("TO-DO: Add cloth to cart and vice versa if already added, remove it")
                                    addClicked.toggle()
                                } label: {
                                    Rectangle()
                                        .frame(width: 165.5, height: 50)
                                        .foregroundStyle(.systemBlack)
                                        .cornerRadius(6)
                                        .overlay(
                                            HStack {
                                                if !addClicked{
                                                    Image(systemName: "plus")
                                                        .font(.body)
                                                        .fontWeight(.regular)
                                                        .foregroundStyle(.systemPureWhite)
                                                    
                                                    Text("Tambah")
                                                        .font(.body)
                                                        .fontWeight(.regular)
                                                        .foregroundStyle(.systemPureWhite)
                                                } else {
                                                    Image(systemName: "xmark")
                                                        .font(.body)
                                                        .fontWeight(.regular)
                                                        .foregroundStyle(.systemPureWhite)
                                                    
                                                    Text("Hapus")
                                                        .font(.body)
                                                        .fontWeight(.regular)
                                                        .foregroundStyle(.systemPureWhite)
                                                }
                                            }
                                        )
                                }
                            case .edit:
                                Button {
                                    let wardrobeVM = WardrobeViewModel.shared
                                    guard
                                        let idx = wardrobeVM.wardrobeItems.firstIndex(of: cloth)
                                    else { return }
                                    navigationRouter.push(to: .EditClothItem(idx: idx))
                                } label: {
                                    Rectangle()
                                        .frame(width: 165.5, height: 50)
                                        .foregroundStyle(.systemBlack)
                                        .cornerRadius(6)
                                        .overlay(
                                            HStack {
                                                Image(systemName: "pencil")
                                                    .font(.body)
                                                    .fontWeight(.regular)
                                                    .foregroundStyle(.systemPureWhite)
                                                
                                                Text("Edit")
                                                    .font(.body)
                                                    .fontWeight(.regular)
                                                    .foregroundStyle(.systemPureWhite)
                                            }
                                        )
                                }
                            }
                            
                            
                        }
                    }
                    .padding(12)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
    }
}

//#Preview {
//    DetailCardView(variantType: .selection, descType: .descON)
//}
