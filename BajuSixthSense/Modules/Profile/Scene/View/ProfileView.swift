//
//  ProfileViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var selection = 0
    let options = [
        (text: "Lemari", image: "cabinet.fill"),
        (text: "Favorit Saya", image: "heart.fill")
    ]
    
//    var catalogItems: [CatalogItemEntity]?
//    @EnvironmentObject var navigationRouter: NavigationRouter
//    @ObservedObject var profileVM = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Color.systemBackground
            VStack {
                HStack {
//                     Text(profileVM.getFirstLetter(items: catalogItems))
                    Text("P")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(18)
                        .background(
                            Circle()
                                .foregroundStyle(.systemBlack)
                        )
                    
                    VStack(alignment: .leading) {
//                         Text(profileVM.getUsername(items: catalogItems))
                        Text("Username")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.labelPrimary)
                        
                        // if catalogItems == nil {
                        Button {
                            // navigationRouter.push(to: .EditProfile)
                        } label: {
                            Text("Edit profile")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelPrimary)
                        }
                        // } else {
                        // Text("\(profileVM.getDistance(items: catalogItems)) km away")
                        // .foregroundStyle(.labelPrimary)
                        // }
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 16)
                
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
//                .padding()
                
                VStack {
                    if selection == 0{
                        ProfileWardrobeView()
                    } else {
                        ProfileBookmarkView()
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        // logic pilih item
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
    ProfileView()
}
