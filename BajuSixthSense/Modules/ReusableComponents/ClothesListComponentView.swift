//
//  ClothesListComponentView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/10/24.
//

import SwiftUI

//struct ClothesListComponentView: View {
//    @State var clothData: ClothEntity
//    
//    @EnvironmentObject var navigationRouter: NavigationRouter
//    @ObservedObject var wardrobeVM: WardrobeViewModel
//    
//    var body: some View {
//        HStack {
//            PhotoFrame(
//                width: 90,
//                height: 110,
//                cornerRadius: 3.49,
//                image: clothData.photos.first ?? nil
//            )
//            
//            VStack(alignment: .leading) {
//                Text("\(clothData.status.rawValue) · \(clothData.lastUpdated)")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                HStack {
//                    Image(systemName: "tray")
//                    Text("\(clothData.quantity ?? 0) clothes")
//                        .fontWeight(.semibold)
//                }
//                .padding(.top, 4)
//                
//                HStack {
//                    if clothData.category.count > 0 {
//                        LabelView(
//                            labelText: clothData.category[0].rawValue,
//                            fontType: .footnote,
//                            horizontalPadding: 5,
//                            verticalPadding: 3
//                        )
//                    }
//                    
//                    if clothData.category.count > 1 {
//                        LabelView(
//                            labelText: clothData.category[1].rawValue,
//                            fontType: .footnote,
//                            horizontalPadding: 5,
//                            verticalPadding: 3
//                        )
//                    }
//                    
//                    if clothData.category.count > 2 {
//                        Text("More")
//                    }
//                }
//                .padding(.horizontal, clothData.category.count == 0 ? 5 : 0)
//                
//                Spacer()
//                
//                switch clothData.status {
//                    case .Draft:
//                        Button {
//                            navigationRouter.push(to: .Upload(state: .Upload, cloth: clothData))
//                        } label: {
//                            ProfileButtonView(
//                                buttonText: clothData.status.getProfileButtonText()
//                            )
//                        }
//                    case .Posted:
//                        Menu {
//                            Button {
//                                do {
//                                    try wardrobeVM.updateClothStatus(
//                                        clothId: clothData.id,
//                                        status: .Given
//                                    )
//                                    wardrobeVM.distributeWardrobe()
//                                    clothData.status = .Given
//                                } catch {
//                                    print("Failed to update cloth status: \(error.localizedDescription)")
//                                }
//                            } label: {
//                                Text("Given")
//                            }
//                            
//                            Text("Cancel")
//                        } label: {
//                            ProfileButtonView(
//                                buttonText: clothData.status.getProfileButtonText()
//                            )
//                        }
//                    case .Given:
//                        Menu {
//                            Button {
//                                do {
//                                    try wardrobeVM.updateClothStatus(
//                                        clothId: clothData.id,
//                                        status: .Posted
//                                    )
//                                    wardrobeVM.distributeWardrobe()
//                                    clothData.status = .Posted
//                                } catch {
//                                    print("Failed to update cloth status: \(error.localizedDescription)")
//                                }
//                            } label: {
//                                Text("Posted")
//                            }
//                            
//                            Text("Cancel")
//                        } label: {
//                            ProfileButtonView(
//                                buttonText: clothData.status.getProfileButtonText()
//                            )
//                        }
//                    default:
//                        EmptyView()
//                }
//            }
//            
//            Spacer()
//            
//            if clothData.status == .Posted {
//                VStack {
//                    Button {
//                        navigationRouter.push(to: .Upload(state: .Edit, cloth: clothData))
//                    } label: {
//                        Image(systemName: "pencil")
//                            .foregroundStyle(.white)
//                            .padding(10)
//                            .background(
//                                Circle()
//                                    .foregroundStyle(.black)
//                            )
//                    }
//                    
//                    Spacer()
//                }
//            }
//        }
//        .frame(height: 120)
//        .onTapGesture {
//            switch clothData.status {
//                case .Initial:
//                    navigationRouter.push(to: .Upload(state: .Upload, cloth: clothData))
//                case .Posted,.Given:
//                    navigationRouter.push(to: .ProductDetail(
//                        bulk: wardrobeVM.mapCatalogItemSelf(cloth: clothData),
//                        isOwner: CatalogViewModel.checkIsOwner(ownerId: clothData.owner))
//                    )
//                case .Error:
//                    print("Error occured from cloth data.")
//            }
//        }
//    }
//}

//#Preview {
//    ClothesListComponentView(clothData: ClothEntity())
//}
