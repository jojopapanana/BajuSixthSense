//
//  EditProfileView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 12/10/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var username: String = ""
    @State private var contact: String = ""
    @State private var location: String = ""
    @State private var isButtonDisabled = true
    
    var body: some View {
        NavigationStack {
            ZStack {
//                Color.backgroundWhite
//                    .ignoresSafeArea()
//
                VStack {
                    ZStack {
                        Circle()
                            .fill(.elevatedLabel)
                        
                        //Change to first Character of user's name
                        Text("J")
                            .font(.system(size: 80))
                    }
                    .frame(width: 145, height: 145)
                    .padding(.bottom, 27)
                    
                    HStack(spacing: 40) {
                        Text("Name")
                        
                        TextField(text: $username, prompt: Text("Required")) {
                            Text("Username")
                        }
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(.white)
                    
                    HStack(spacing: 25) {
                        Text("Contact")
                        
                        TextField(text: $contact, prompt: Text("Required")) {
                            Text("Contact")
                        }
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(.white)
                    
                    Text("Enter your phone number so others can reach out to you about your clothing")
                        .font(.caption)
                        .foregroundStyle(.systemGrey1)
                    
                    
                    VStack(alignment: .leading) {
                        Text("ADDRESS")
                            .font(.caption)
                            .foregroundStyle(.systemGrey1)
                            .padding(.leading, 16)
                        
                        HStack(spacing: 20) {
                            Text("Location")
                            
                            Text("Banten, Kab. Tangerang, Cisauk")
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 44)
                        .background(.white)
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                    
                    Button {
                    #warning("TO-DO: implement saving update functionality")
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.white)
                            CustomButtonView(buttonType: .primary, buttonWidth: 360, buttonLabel: "Save", isButtonDisabled: $isButtonDisabled)
                        }
                        .ignoresSafeArea()
                        .frame(height: 80)
                    }
                }
                .onChange(of: username) { oldValue, newValue in
                    if !username.isEmpty && !contact.isEmpty && oldValue != newValue {
                        isButtonDisabled = false
                    } else if username.isEmpty || contact.isEmpty {
                        isButtonDisabled = true
                    }
                }
                .onChange(of: contact) { oldValue, newValue in
                    if !username.isEmpty && !contact.isEmpty && oldValue != newValue {
                        isButtonDisabled = false
                    } else if username.isEmpty || contact.isEmpty {
                        isButtonDisabled = true
                    }
                }
            }
            .padding(.top, 12)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EditProfileView()
}
