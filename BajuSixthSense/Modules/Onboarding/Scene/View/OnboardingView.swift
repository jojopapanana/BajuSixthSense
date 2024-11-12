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
    
    #warning("TO-DO: Please change all the qty with user's actual number of recommendation")
    @State private var qty = 0
    
    @Binding var isOnBoarded: Bool
    @StateObject var onboardingVM = OnboardingViewModel()
    
    var formatter: NumberFormatter = NumberFormatter()
    
    var body: some View {
        ZStack {
            ZStack {
                Color.systemBackground
                    .ignoresSafeArea()
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Selamat datang di Kelothing!")
                            .font(.title)
                            .bold()
                            .padding(.top, 56)
                            .padding(.bottom, 4)
                        
                        
                        Text("Untuk memberikan kamu rekomendasi personal, kami membutuhkan nama, nomor handphone, dan alamatmu. Hal ini membantu kami untuk menawarkan baju-baju terdekat denganmu!")
                            .font(.subheadline)
                            .foregroundStyle(Color.labelSecondary2)
                            .padding(.bottom, 45)
                        
                            Text("Nama\(Text("*").foregroundStyle(.red))")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 4)
                            
                            TextField(
                                "Tuliskan namamu",
                                text: $onboardingVM.user.username,
                                prompt: Text("Tuliskan namamu")
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .onChange(of: onboardingVM.user.username) { oldValue, newValue in
                                isButtonDisabled = !onboardingVM.checkDataAvail() && requestLocation
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.systemBlack, lineWidth: 1)
                            )
                        
                            Text("Nomor Handphone\(Text("*").foregroundStyle(.red))")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 4)
                            
                            TextField(
                                "Tuliskan nomor handphonemu",
                                text: $onboardingVM.user.contactInfo,
                                prompt: Text("Tuliskan nomor handphonemu")
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .onChange(of: onboardingVM.user.contactInfo) { oldValue, newValue in
                                isButtonDisabled = !onboardingVM.checkDataAvail() && requestLocation
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.systemBlack, lineWidth: 1)
                            )
                            
                            Text("Isi nomor teleponmu, supaya pengguna lain bisa langsung menghubungi kamu jika tertarik.")
                                .font(.caption)
                                .foregroundStyle(Color.labelSecondary2)
                                .padding(.bottom, 16)
                            
                                Text("Alamat\(Text("*").foregroundStyle(.red))")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 100, alignment: .leading)
                                
                                HStack {
                                    Text(
                                        onboardingVM.user.address.isEmpty ? "Lokasi Saat Ini" : onboardingVM.user.address
                                    )
                                    .foregroundStyle(!onboardingVM.user.address.isEmpty ? .labelPrimary : .labelSecondary2)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.tertiary)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.systemBlack, lineWidth: 1)
                                )
                                .onTapGesture {
                                    showSheet = true
                                    requestLocation.toggle()
                                }
                                .onChange(of: showSheet) { oldValue, newValue in
                                    isButtonDisabled = !onboardingVM.checkDataAvail()
                                }
                        
                        Text("Saran pakaian yang perlu diambil\(Text("*").foregroundStyle(.red))")
                            .font(.footnote)
                            .padding(.top, 16)
                            .padding(.bottom, 4)
                        
                        HStack {
                            TextField(
                                "0",
                                value: $qty,
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
                                        let count = qty
                                        if count > 0 {
                                            qty = count - 1
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
                                        let count = qty
                                        if count == 0 {
                                            qty = 1
                                        } else {
                                            qty = count + 1
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
                                    try await onboardingVM.registerUser()
                                    isOnBoarded.toggle()
                                } catch {
                                    print("Failed Registering New User: \(error.localizedDescription)")
                                }
                            }
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
