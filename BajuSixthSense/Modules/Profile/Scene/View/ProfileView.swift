//
//  ProfileViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var selection = 0
    @State private var showSelection = false
//    @State var sharedState: SharedState
    
    
    let options = [
        (text: "Lemari", image: "cabinet.fill"),
        (text: "Favorit Saya", image: "heart.fill")
    ]
    
    enum variantType {
        case penerima
        case pemberi
    }
    
    var VariantType: variantType
    
    // PR LU:
    // 1. sesuaikan BajuSixthSense dengan Profile_BajuSixhbsjefviske_1 (bagian profileView dkk)
    // 2. bikin switch case pemberi dan penerima di ProfileView, ProfileWardrobe, dan KAWAN KWAN
    // 3. nyanyi lagu hindia
    
    var body: some View {
        ZStack {
            Color.systemBackground
            VStack {
                HStack {
                    Text("P")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(18)
                        .background(
                            Circle()
                                .foregroundStyle(.systemBlack)
                        )
                    
                    VStack(alignment: .leading) {
                        Text("Username")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.labelPrimary)
                        
                        switch VariantType {
                            
                        case .penerima:
                            Text("1 km") // distance
                                .font(.footnote)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelSecondary)
                            
                        case .pemberi:
                            Button {
                                // navigationRouter.push(to: .EditProfile)
                            } label: {
                                Text("Edit profile")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelPrimary)
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                switch VariantType {
                    
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
                    
                    switch VariantType {
                    case .penerima:
                        ProfileWardrobeView(showSelection: $showSelection, VariantType: .penerima)
                    case .pemberi:
                        if selection == 0 {
                            ProfileWardrobeView(showSelection: $showSelection, VariantType: .penerima)
                        } else {
                            ProfileBookmarkView()
                        }
                    }
                    
                    switch VariantType {
                    case .penerima:
//                        if sharedState.cartSelected {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "basket.fill")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.labelPrimary)
                                    Text("3 Item")
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
                                    // ke keranjang
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
//                        } else {
//                            EmptyView()
//                        }
                        
                    case .pemberi:
                        if (showSelection) {
                            Button {
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
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        showSelection.toggle()
                    } label: {
                        Label("Pilih Item", systemImage: "checkmark.circle")
                    }
                    
                    Button {
                        // logic bagikan
                    } label: {
                        Label("Bagikan", systemImage: "square.and.arrow.up")
                    }
                } label: {
                    Text("Ubah")
                }
            }
        }
    }
}

#Preview {
    ProfileView(VariantType: .penerima)
}
