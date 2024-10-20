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
    @State private var username = ""
    
    @Binding var isOnBoarded: Bool
    @StateObject var onboardingVM = OnboardingViewModel()
    
    var body: some View {
        ZStack {
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
                            "Required",
                            text: $onboardingVM.user.username,
                            prompt: Text("Required")
                        )
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .onChange(of: onboardingVM.user.username) { oldValue, newValue in
                            isButtonDisabled = !onboardingVM.checkDataAvail() && requestLocation
                        }
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
                            "Required",
                            text: $onboardingVM.user.contactInfo,
                            prompt: Text("Required")
                        )
                        .keyboardType(.numberPad)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .onChange(of: onboardingVM.user.contactInfo) { oldValue, newValue in
                            isButtonDisabled = !onboardingVM.checkDataAvail() && requestLocation
                        }
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
                    .onChange(of: showSheet) { oldValue, newValue in
                        isButtonDisabled = !onboardingVM.checkDataAvail()
                    }
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        
                        Button {
                            Task {
                                do {
                                    try await onboardingVM.registerUser()
                                    isOnBoarded.toggle()
                                } catch {
                                    print("Failed Registering New User: \(error.localizedDescription)")
                                }
                            }
                        } label: {
                            CustomButtonView(buttonType: .primary, buttonWidth: 360, buttonLabel: "Continue", isButtonDisabled: $isButtonDisabled)
                        }
                        .disabled(isButtonDisabled)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
            .onTapGesture {
                self.hideKeyboard()
            }
        }
        .sheet(isPresented: $showSheet) {
            SheetLocationOnboardingView(
                showSheet: $showSheet,
                userAddress: $onboardingVM.user.address,
                vm: onboardingVM
            )
        }
    }
}

//#Preview {
//    OnboardingView()
//}
