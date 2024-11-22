//
//  OnboardingView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 14/10/24.
//

import SwiftUI
import CoreLocation

struct OnboardingView: View {
    @State var requestLocation = true
    @State var showSheet = false
    @State private var isButtonDisabled = true
    @State private var username = ""
    @State private var isSkipped = false
        
    @Binding var isOnBoarded: Bool
    @StateObject var onboardingVM = OnboardingViewModel()
    
    var formatter: NumberFormatter = NumberFormatter()
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.systemBackground
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Selamat datang di Kelothing!")
                        .font(.title)
                        .bold()
                        .padding(.top, 45)
                        .padding(.bottom, 4)
                    
                    
                    Text("Untuk memberikan kamu rekomendasi personal, kami membutuhkan nama, nomor handphone, dan alamatmu. Hal ini membantu kami untuk menawarkan baju-baju terdekat denganmu!")
                        .font(.subheadline)
                        .foregroundStyle(Color.labelSecondary2)
                        .padding(.bottom, 45)
                    
                    Text("Nama")
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
//                    .onChange(of: onboardingVM.user.username) { oldValue, newValue in
//                        isButtonDisabled = !onboardingVM.checkDataAvail() && requestLocation
//                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.systemBlack, lineWidth: 1)
                    )
                    
                    Text("Nomor Handphone")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 16)
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
//                    .onChange(of: onboardingVM.user.contactInfo) { oldValue, newValue in
//                        isButtonDisabled = !onboardingVM.checkDataAvail() && requestLocation
//                    }
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
                        isSkipped = false
                        showSheet = true
                        requestLocation.toggle()
//                        print("vm location: \(onboardingVM.location)")
                    }
                    .onChange(of: onboardingVM.location) { oldValue, newValue in
                        isButtonDisabled = (onboardingVM.location == CLLocation(latitude: 0, longitude: 0))
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack{
                    Button {
                        if onboardingVM.location.coordinate.latitude == 0 && onboardingVM.location.coordinate.longitude == 0 {
                            isSkipped = true
                            self.showSheet.toggle()
                        } else {
                            Task {
                                do {
                                    try await onboardingVM.registerUser()
                                    isOnBoarded.toggle()
                                } catch {
                                    print("Failed Registering New User: \(error.localizedDescription)")
                                }
                            }
                        }
                    } label: {
                        Rectangle()
                            .frame(width: 162, height: 50)
                            .foregroundStyle(.systemPureWhite)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                    .foregroundStyle(.systemBlack)
                            )
                            .overlay(
                                Text("Lewati")
                                    .foregroundStyle(.systemBlack)
                            )
                    }
                    
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
                        CustomButtonView(buttonType: .primary, buttonWidth: 175, buttonLabel: "Lanjut", isButtonDisabled: $isButtonDisabled)
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
                isOnboarded: $isOnBoarded,
                vm: onboardingVM, isSkipped: $isSkipped
            )
        }
//        .toolbar{
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    if onboardingVM.location.coordinate.latitude == 0 && onboardingVM.location.coordinate.longitude == 0 {
//                        isSkipped = true
//                        self.showSheet.toggle()
//                    } else {
//                        Task {
//                            do {
//                                try await onboardingVM.registerUser()
//                                isOnBoarded.toggle()
//                            } catch {
//                                print("Failed Registering New User: \(error.localizedDescription)")
//                            }
//                        }
//                    }
//                } label: {
//                    Text("Skip")
//                }
//            }
//        }
    }
}

//#Preview {
//    OnboardingView()
//}
