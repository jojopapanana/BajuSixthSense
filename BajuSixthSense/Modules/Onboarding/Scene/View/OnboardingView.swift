//
//  OnboardingView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 14/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @State var requestLocation = true
    @State var showSheet = false
    @State private var isButtonDisabled = true
    
    @ObservedObject var onboardingVM = OnboardingViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.systemBGBase
                    .ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Welcome to Kelothing")
                            .font(.title)
                            .bold()
                            .padding(.top, 56)
                            .padding(.bottom, 4)
                        
                        Text("To provide you with personalized recommendations, we need your name, contact, and address. This helps us suggest the closest bulks available near you.")
                            .font(.subheadline)
                            .foregroundStyle(Color.systemGrey1)
                            .padding(.bottom, 56)
                    }
                    
                    HStack {
                        Text("Name")
                            .multilineTextAlignment(.leading)
                            .frame(width: 100, alignment: .leading)
                            .padding(.leading, 16)
                        
                        TextField(
                            text: $onboardingVM.user.username,
                            prompt: Text("Required")
                        ) {
                            
                        }
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    }
                    .frame(width: 361, height: 44)
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    HStack {
                        Text("Contact")
                            .multilineTextAlignment(.leading)
                            .frame(width: 100, alignment: .leading)
                            .padding(.leading, 16)
                        
                        TextField(
                            text: $onboardingVM.user.contactInfo,
                            prompt: Text("Required")
                        ) {
                            
                        }
                        .keyboardType(.numberPad)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    }
                    .frame(width: 361, height: 44)
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    Text("Enter your phone number so others can reach out to you about your clothing")
                        .font(.caption)
                        .foregroundStyle(Color.systemGrey1)
                    
                    HStack {
                        Text("Address")
                            .multilineTextAlignment(.leading)
                            .frame(width: 100, alignment: .leading)
                        
                        Spacer()
                        
                        HStack {
                            Text(
                                onboardingVM.user.address.isEmpty ? "Current Location" : onboardingVM.user.address
                            )
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: 200, alignment: .trailing)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                        }
                        .onTapGesture {
                            showSheet = true
                            requestLocation.toggle()
                        }
                    }
                    .padding()
                    .frame(width: 361, height: 44)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.top, 16)
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        
                        #warning("Add function to register the user.")
                        NavigationLink{
                            CatalogView()
                        } label: {
                            CustomButtonView(buttonType: .primary, buttonWidth: 360, buttonLabel: "Continue", isButtonDisabled: $isButtonDisabled)
                                .onTapGesture {
                                    Task {
                                        do {
                                            try await onboardingVM.registerUser()
                                        } catch {
                                            print("Failed Register: \(error.localizedDescription)")
                                        }
                                    }
                                }
                        }
                        .disabled(isButtonDisabled)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
            .onChange(of: onboardingVM.user.username) { oldValue, newValue in
                if onboardingVM.checkDataAvail() && !requestLocation {
                    isButtonDisabled = false
                }
            }
            .onChange(of: onboardingVM.user.contactInfo) { oldValue, newValue in
                if onboardingVM.checkDataAvail() && !requestLocation {
                    isButtonDisabled = false
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            SheetLocationOnboardingView(
                showSheet: $showSheet,
                userAddress: $onboardingVM.user.address
            )
        }
    }
}

#Preview {
    OnboardingView()
}
