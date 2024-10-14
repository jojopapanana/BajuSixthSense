//
//  OnboardingView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 14/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @State var requestLocation = false
    @State var showSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.systemBg
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("Welcome to Kelothing")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 56)
                        .padding(.bottom, 4)
                    
                    Text("To provide you with personalized recommendations, we need your name, contact, and address. This helps us suggest the closest bulks available near you.")
                        .font(.subheadline)
                        .foregroundStyle(Color.systemGrey)
                        .padding(.horizontal)
                        .padding(.bottom, 56)
                    
                    HStack {
                        Text("Name")
                            .multilineTextAlignment(.leading)
                            .frame(width: 100, alignment: .leading)
                            .padding(.leading, 16)
                        
                        TextField("Required", text: .constant(""))
                    }
                    .frame(width: 361, height: 44)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Contact")
                            .multilineTextAlignment(.leading)
                            .frame(width: 100, alignment: .leading)
                            .padding(.leading, 16)
                        
                        TextField("Required", text: .constant(""))
                    }
                    .frame(width: 361, height: 44)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Text("Enter your phone number so others can reach out to you about your clothing")
                        .font(.caption)
                        .foregroundStyle(Color.systemGrey)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Address")
                            .multilineTextAlignment(.leading)
                            .frame(width: 100, alignment: .leading)
                            .padding(.leading, 16)
                        Spacer()
                        HStack {
                            Text("Current Location")
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                        }
                        .onTapGesture {
                            showSheet = true
                            requestLocation.toggle()
                        }
                        .padding(.trailing, 16)
                    }
                    .frame(width: 361, height: 44)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.top, 16)
                    
                    Spacer()
                    NavigationLink(destination: CatalogView()) {
                        Rectangle()
                            .frame(width: 360, height: 50)
                            .foregroundStyle(requestLocation ? Color.systemPrimary : Color.systemGrey2)
                            .cornerRadius(12)
                            .overlay(
                                Text("Continue")
                                    .font(.system(size: 17))
                                    .foregroundStyle(requestLocation ? Color.systemWhite : Color.systemGrey)
                            )
                            .padding(.horizontal)
                    }
                    .disabled(!requestLocation)                    
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            SheetLocationOnboardingView()
        }
    }
}

#Preview {
    OnboardingView()
}
