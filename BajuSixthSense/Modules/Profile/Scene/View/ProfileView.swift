// 
//  ProfileViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct ProfileView: View {
    var isOwner:Bool
    @State private var selection = 0
    let options = [
        (text: "Wardrobe", image: "cabinet.fill"),
        (text: "Bookmark", image: "bookmark.fill")
    ]
    let clothes: [CatalogItemEntity] = [
        CatalogItemEntity(clothID: "cloth1", owner: ItemOwnerEntity(username: "un1", contactInfo: "08111111111", coordinate: (lat: 0, lon: 0)), photos: [], quantity: 10, category: [.Shirt, .Sweater], additionalNotes: "bajunya bagus semua", lastUpdated: Date(), status: .Posted)
    ]
    
    var body: some View {
        NavigationStack{
                ZStack{
//                    Color.backgroundWhite
                    
                    Rectangle()
                        .fill(.systemWhite)
                        .ignoresSafeArea()
                        .frame(height: 110)
                        .position(x: 201, y: 60)
                    
                    VStack(alignment: .leading){
                        HStack(spacing: 20){
                            Text("J") //Inject value
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding(18)
                                .background(
                                    Circle()
                                        .foregroundStyle(.systemPrimary)
                                )
                            VStack(alignment: .leading){
                                Text("Jessica") //Inject name
                                if isOwner{
                                    NavigationLink{
                                        EditProfileView()
                                    } label: {
                                        Text("Edit profile")
                                            .foregroundStyle(.systemGrey1)
                                    }
                                } else {
                                    //TODO: change the number to distance from user
                                    Text("1 km away") //inject distance
                                        .foregroundStyle(.systemGrey1)
                                }
                            }
                        }
                        .frame(height: 100)
                        .padding(.top, 11)
                        
                        if isOwner{
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
                            
                            ScrollView{
                                if selection == 0{
                                    ProfileWardrobeView()
                                } else {
                                    HStack {
                                        Spacer()
                                        ProfileBookmarkView(bulks: clothes)
                                            .padding(.horizontal, -16)
                                        Spacer()
                                    }
                                    .padding(.horizontal, -16)
                                    .padding(.top, 4)
                                }
                            }
                        } else {
                            ScrollView{
                                ProfileBookmarkView(bulks: clothes)
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
    ProfileView(isOwner: false)
}
