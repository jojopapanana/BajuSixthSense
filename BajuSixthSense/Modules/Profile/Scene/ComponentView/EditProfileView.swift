//
//  EditProfileView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 12/10/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var isButtonDisabled = true
    @ObservedObject var profileVM = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.systemBGBase
                    .ignoresSafeArea()

                VStack {
                    ZStack {
                        Circle()
                            .fill(.elevatedLabel)
                        
                        Text(profileVM.firstLetter)
                            .font(.system(size: 80))
                    }
                    .frame(width: 145, height: 145)
                    .padding(.bottom, 27)
                    
                    HStack(spacing: 40) {
                        Text("Name")
                        
                        TextField(
                            text: $profileVM.selfUser.username,
                            prompt: Text("Required")
                        ) {
                            Text(profileVM.selfUser.username)
                        }
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(.white)
                    .onChange(of: profileVM.selfUser.username) { oldValue, newValue in
                        profileVM.checkDisableButton()
                        isButtonDisabled = profileVM.disableButton
                    }
                    
                    HStack(spacing: 25) {
                        Text("Contact")
                        
                        TextField(
                            text: $profileVM.selfUser.contactInfo,
                            prompt: Text("Required")
                        ) {
                            Text(profileVM.selfUser.contactInfo)
                        }
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 44)
                    .background(.white)
                    .onChange(of: profileVM.selfUser.contactInfo) { oldValue, newValue in
                        profileVM.checkDisableButton()
                        isButtonDisabled = profileVM.disableButton
                    }
                    
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
                            
                            Spacer()
                            
                            HStack {
                                Text(profileVM.selfUser.address.isEmpty ? "Current Location" : profileVM.selfUser.address)
//                                    .foregroundStyle(.secondary)
//                                Image(systemName: "chevron.right")
//                                    .foregroundStyle(.tertiary)
                            }
                            .onTapGesture {
                            #warning("Pak PM blg nggk ush dulu")
                            }
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 44)
                        .background(.white)
                    }
                    .padding(.top, 16)
                    .onChange(of: profileVM.selfUser.address) { oldValue, newValue in
                        profileVM.checkDisableButton()
                        isButtonDisabled = profileVM.disableButton
                    }
                    
                    Spacer()
                    
                    Button {
                        do {
                            try profileVM.updateUser()
                        } catch {
                            print("Fail saving changes: \(error.localizedDescription)")
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.white)
                            
                            CustomButtonView(buttonType: .primary, buttonWidth: 360, buttonLabel: "Save", isButtonDisabled: $isButtonDisabled)
                        }
                        .ignoresSafeArea()
                        .frame(height: 80)
                    }
                    .disabled(profileVM.disableButton)
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
