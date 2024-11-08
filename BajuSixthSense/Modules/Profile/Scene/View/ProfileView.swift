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
    @EnvironmentObject var navigationRouter: NavigationRouter
    @ObservedObject var profileVM = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Color.systemBackground
            
            Rectangle()
                .fill(.systemPureWhite)
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
                                .foregroundStyle(.systemPurple)
                        )
                    VStack(alignment: .leading){
                        Text(profileVM.getUsername(items: catalogItems))
                        if catalogItems == nil {
                            Button {
                                navigationRouter.push(to: .EditProfile)
                            } label: {
                                Text("Edit profile")
                                    .foregroundStyle(.labelPrimary)
                            }
                        } else {
                            Text("\(profileVM.getDistance(items: catalogItems)) km away")
                                .foregroundStyle(.labelPrimary)
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
                    
                    VStack {
                        if selection == 0{
                            ProfileWardrobeView()
                        } else {
                            ScrollView {
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

#Preview {
    ProfileView()
}
