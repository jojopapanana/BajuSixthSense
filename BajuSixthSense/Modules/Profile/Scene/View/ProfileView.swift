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
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    Rectangle().fill(.backgroundWhite)
                        .ignoresSafeArea()
                    
                    Rectangle()
                        .fill(.systemWhite)
                        .ignoresSafeArea()
                        .frame(height: 110)
                        .position(x: 201, y: 60)
                    
                    VStack(alignment: .leading){
                        HStack(spacing: 20){
                            Text("J")
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding(18)
                                .background(
                                    Circle()
                                        .foregroundStyle(.systemPurple)
                                )
                            VStack(alignment: .leading){
                                Text("Jessica")
                                Text("Edit profile")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                        .padding(.top, 11)
                        
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
                        
                        ScrollView{
                            if selection == 0{
                                ProfileWardrobeView()
                            } else {
                                ProfileBookmarkView()
                                    .padding(-16)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
