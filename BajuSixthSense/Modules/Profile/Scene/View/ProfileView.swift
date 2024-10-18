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
        (text: "Wardrobe", image: "cabinet.fill"),
        (text: "Bookmark", image: "bookmark.fill")
    ]
    
    var catalogItems: [CatalogItemEntity]?
    @ObservedObject var profileVM = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.systemBGBase
                
                Rectangle()
                    .fill(.systemWhite)
                    .ignoresSafeArea()
                    .frame(height: 110)
                    .position(x: 201, y: 60)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 20) {
                        Text(profileVM.getFirstLetter(items: catalogItems))
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(18)
                            .background(
                                Circle()
                                    .foregroundStyle(.systemPrimary)
                            )
                        VStack(alignment: .leading){
                            Text(profileVM.getUsername(items: catalogItems))
                            if catalogItems == nil {
                                NavigationLink{
                                    EditProfileView()
                                } label: {
                                    Text("Edit profile")
                                        .foregroundStyle(.systemGrey1)
                                }
                            } else {
                                //TODO: change the number to distance from user
                                Text("\(profileVM.getDistance(items: catalogItems)) km away")
                                    .foregroundStyle(.systemGrey1)
                            }
                        }
                    }
                    .frame(height: 100)
                    .padding(.top, 11)
                    
                    if catalogItems == nil {
                        HStack {
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    selection = index
                                }) {
                                    HStack {
                                        Image(systemName: options[index].image)
                                        Text(options[index].text)
                                            .fontWeight(.semibold)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .foregroundColor(.black)
                                    .background(selection == index ? Color.white : Color.clear)
                                    .cornerRadius(8)
                                }
                                .padding(3)
                            }
                        }
                        .frame(height: 40)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom, 22)
                        .padding(.top, -20)
                        
                        ScrollView {
                            if selection == 0{
                                ProfileWardrobeView()
                            } else {
                                HStack {
                                    Spacer()
                                    
                                    ProfileBookmarkView(catalogItems: nil)
                                        .padding(.horizontal, -16)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, -16)
                                .padding(.top, 4)
                            }
                        }
                    } else {
                        ScrollView{
                            ProfileBookmarkView(catalogItems: catalogItems)
                                .padding(-16)
                                .padding(.top, 20)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
