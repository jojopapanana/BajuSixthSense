//
//  ProfileViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI
import RiveRuntime

enum UserVariantType {
    case penerima
    case pemberi
}

struct ProfileView: View {
    @State private var selection = 0
    @State private var showSelection = false
    @State var chosenClothes = [ClothEntity]()
    
    let options = [
        (text: "Lemari", image: "cabinet.fill"),
        (text: "Favorit Saya", image: "heart.fill")
    ]
    
    var variantType: UserVariantType
    @State var presentSheet: Bool
    @State var clothData: ClothEntity
    @ObservedObject var profileVM: ProfileViewModel
    @ObservedObject var wardrobeVM: WardrobeViewModel
    @ObservedObject var cartVM = ClothCartViewModel.shared
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    var body: some View {
        ZStack {
            Color.systemBackground
            
            VStack {
                HStack {
                    Text(profileVM.firstLetter)
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(18)
                        .background(
                            Circle()
                                .foregroundStyle(.systemBlack)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(profileVM.selfUser.username)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.labelPrimary)
                        
                        switch variantType {
                            case .penerima:
                                Text(profileVM.getUserDistance())
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelSecondary)
                                
                            case .pemberi:
                                NavigationLink {
                                    EditProfileView()
                                } label: {
                                    Text("Edit profil")
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                        .foregroundStyle(.labelSecondary2)
                                }
                        }

                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                switch variantType {
                    case .penerima:
                        EmptyView()
                        
                    case .pemberi:
                        HStack {
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    selection = index
                                }) {
                                    HStack {
                                        Image(systemName: options[index].image)
                                            .font(.system(size: 13))
                                            .fontWeight(.semibold)
                                        
                                        Text(options[index].text)
                                            .font(.system(size: 13))
                                            .fontWeight(.semibold)
                                    }
                                    .frame(width: 173, height: 36)
                                    .foregroundColor(.black)
                                    .background(selection == index ? Color.white : Color.clear)
                                    .cornerRadius(8)
                                    .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
                                    .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
                                }
                                .padding(3)
                            }
                        }
                        .frame(height: 40)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom, 18)
                }
                
                VStack {
                    if profileVM.selfUser.userID == nil && wardrobeVM.wardrobeItems.isEmpty {
                        Spacer()
                        RiveViewModel(fileName: "shellyloading-4").view()
                            .frame(width: 200, height: 200)
                        Spacer()
                    } else {
                        switch variantType {
                            case .penerima:
                                ProfileWardrobeView(
                                    isSheetPresented: $presentSheet,
                                    selectedCloth: $clothData,
                                    clothes: $chosenClothes,
                                    showSelection: $showSelection,
                                    variantType: .penerima,
                                    user: ClothOwner(userID: profileVM.selfUser.userID ?? "", username: profileVM.selfUser.username, contact: profileVM.selfUser.contactInfo, latitude: profileVM.selfUser.coordinate.lat, longitude: profileVM.selfUser.coordinate.lon, sugestedAmount: profileVM.selfUser.sugestedMinimal),
                                    wardrobeVM: wardrobeVM
                                )
                            case .pemberi:
                                if selection == 0 {
                                    ProfileWardrobeView(
                                        isSheetPresented: $presentSheet,
                                        selectedCloth: $clothData,
                                        clothes: $chosenClothes,
                                        showSelection: $showSelection,
                                        variantType: .pemberi,
                                        user: ClothOwner(userID: profileVM.selfUser.userID ?? "", username: profileVM.selfUser.username, contact: profileVM.selfUser.contactInfo, latitude: profileVM.selfUser.coordinate.lat, longitude: profileVM.selfUser.coordinate.lon, sugestedAmount: profileVM.selfUser.sugestedMinimal),
                                        wardrobeVM: wardrobeVM
                                    )
                                } else {
                                    ProfileFavoritesView()
                                }
                        }
                    }
                    
                    switch variantType {
                        case .penerima:
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "basket.fill")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.labelPrimary)
                                    
                                    Text("\(cartVM.catalogCart.clothItems.count) Item")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.labelPrimary)
                                        .padding(.leading, -4)
                                }
                                
                                Text("Pilih lebih banyak yuk, biar penampilan lebih beragam!")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelSecondary)
                                
                                Button {
                                    navigationRouter.push(to: .ClothCart)
                                } label: {
                                    Rectangle()
                                        .frame(width: 361, height: 50)
                                        .foregroundStyle(.systemPurple)
                                        .cornerRadius(6)
                                        .overlay(
                                            Text("Lihat Keranjang")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundStyle(.systemPureWhite)
                                        )
                                }
                            }
                            
                        case .pemberi:
                            if (showSelection) {
                                Button {
                                    wardrobeVM.updateClothesStatuses(clothes: chosenClothes)
                                    showSelection.toggle()
                                } label: {
                                    Rectangle()
                                        .frame(width: 361, height: 50)
                                        .foregroundStyle(.systemPurple)
                                        .cornerRadius(6)
                                        .overlay(
                                            Text("Ubah status")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundStyle(.systemPureWhite)
                                        )
                                }
                            } else {
                                EmptyView()
                            }
                    }
                }
            }
        }
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            switch variantType {
            case .penerima:
                ToolbarItem{
                    EmptyView()
                }
            case .pemberi:
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            showSelection.toggle()
                        } label: {
                            Label("Pilih Item", systemImage: "checkmark.circle")
                        }
                        
                        ShareLink(
                            item: profileVM.generateShareUserLink(userId: profileVM.selfUser.userID),
                            message: Text("Check out this giver!\n\n\(profileVM.generateShareUserLink(userId: profileVM.selfUser.userID))")
                        ) {
                            Label("Bagikan", systemImage: "square.and.arrow.up")
                        }
                        .foregroundStyle(.systemBlack)
                        
//                        #warning("This should be a sharelink?")
//                        Button {
//                            #warning("TO-DO: Implement sharing functionality")
//                        } label: {
//                            Label("Bagikan", systemImage: "square.and.arrow.up")
//                        }
                    } label: {
                        Text("Ubah")
                    }
                }
            }
        }
        .onChange(of: clothData) { oldValue, newValue in
            print(clothData.id ?? "why no id")
        }
    }
}

//#Preview {
//    ProfileView(VariantType: .pemberi)
//}
