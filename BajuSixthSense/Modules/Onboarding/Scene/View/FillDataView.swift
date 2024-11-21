//
//  FillDataView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 22/11/24.
//

import SwiftUI

struct FillDataView: View {
    @State private var isButtonDisabled = true
    
    var formatter: NumberFormatter = NumberFormatter()
    
    @StateObject var profileVM = ProfileViewModel()
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        ZStack {
            ZStack {
                Color.systemBackground
                    .ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Tunggu dulu...")
                            .font(.title)
                            .bold()
                            .padding(.top, 56)
                            .padding(.bottom, 4)
                        
                        
                        Text("Sebelum kamu lanjut, isi dulu data dibawah ini yaa")
                            .font(.subheadline)
                            .foregroundStyle(Color.labelSecondary2)
                            .padding(.bottom, 45)
                        
                            Text("Nama")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 4)
                            
                            TextField(
                                "Tuliskan namamu",
                                text: $profileVM.selfUser.username,
                                prompt: Text("Tuliskan namamu")
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .onChange(of: profileVM.selfUser.username) { oldValue, newValue in
                                isButtonDisabled = profileVM.selfUser.username.isEmpty && profileVM.selfUser.contactInfo.isEmpty
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.systemBlack, lineWidth: 1)
                            )
                        
                            Text("Nomor Handphone")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 4)
                            
                            TextField(
                                "Tuliskan nomor handphonemu",
                                text: $profileVM.selfUser.contactInfo,
                                prompt: Text("Tuliskan nomor handphonemu")
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .onChange(of: profileVM.selfUser.contactInfo) { oldValue, newValue in
                                isButtonDisabled = profileVM.selfUser.username.isEmpty && profileVM.selfUser.contactInfo.isEmpty
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.systemBlack, lineWidth: 1)
                            )
                            
                            Text("Isi nomor teleponmu, supaya pengguna lain bisa langsung menghubungi kamu jika tertarik.")
                                .font(.caption)
                                .foregroundStyle(Color.labelSecondary2)
                                .padding(.bottom, 16)
                        
                        Text("Saran pakaian yang perlu diambil")
                            .font(.footnote)
                            .padding(.top, 16)
                            .padding(.bottom, 4)
                        
                        HStack {
                            TextField(
                                "0",
                                value: $profileVM.selfUser.sugestedMinimal,
                                formatter: formatter
                            )
                            .frame(width: 70, height: 32)
                            .keyboardType(.numberPad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                            )
                            .multilineTextAlignment(.center)
                            .padding(.trailing, 5)
                            
                            HStack(spacing: 0) {
                                Image(systemName: "minus")
                                    .frame(width: 47, height: 32)
                                    .contentShape(RoundedRectangle(cornerRadius: 10))
                                    .foregroundStyle(Color.systemPureWhite)
                                    .onTapGesture {
                                        let count = profileVM.selfUser.sugestedMinimal
                                        if count > 0 {
                                            profileVM.selfUser.sugestedMinimal = count - 1
                                        }
                                    }
                                
                                Divider()
                                    .frame(width: 1, height: 18)
                                    .foregroundStyle(Color.labelPrimary)
                                
                                Image(systemName: "plus")
                                    .frame(width: 47, height: 32)
                                    .contentShape(RoundedRectangle(cornerRadius: 10))
                                    .foregroundStyle(Color.systemPureWhite)
                                    .onTapGesture {
                                        let count = profileVM.selfUser.sugestedMinimal
                                        if count == 0 {
                                            profileVM.selfUser.sugestedMinimal = 1
                                        } else {
                                            profileVM.selfUser.sugestedMinimal = count + 1
                                        }
                                    }
                            }
                            .frame(width: 94, height: 32)
                            .background(Color.systemBlack)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Text("Jangan ragu untuk menyarankan orang lain lebih dari satu barang, agar mereka lebih tertarik!")
                            .font(.caption)
                            .foregroundStyle(.labelSecondary2)
                            .padding(.top, 4)
                    }
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        
                        Button {
                            Task {
                                do {
                                    try profileVM.updateUser()
                                } catch {
                                    print("Failed Updating User: \(error.localizedDescription)")
                                }
                            }
                            
                            navigationRouter.goBack()
                        } label: {
                            CustomButtonView(buttonType: .primary, buttonWidth: 360, buttonLabel: "Selanjutnya", isButtonDisabled: $isButtonDisabled)
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
    }
}

#Preview {
    FillDataView()
}
