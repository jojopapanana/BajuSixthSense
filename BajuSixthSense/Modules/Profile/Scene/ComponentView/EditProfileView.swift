//
//  EditProfileView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 12/10/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var isButtonDisabled = false
    @ObservedObject var profileVM = ProfileViewModel()
    
    var formatter: NumberFormatter = NumberFormatter()
    
    @State var qty: Int?
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.systemBackground
            
            VStack {
                ZStack {
                    Circle()
                        .fill(.elevatedLabel)
                    
                    Text("P")
                        .font(.system(size: 80))
                }
                .frame(width: 145, height: 145)
                .padding(.bottom, 27)
                
                VStack(alignment: .leading, spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nama\(Text("*").foregroundStyle(.red))")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundStyle(.labelPrimary)
                        
                        Rectangle()
                            .frame(width: 362, height: 32)
                            .foregroundStyle(.clear)
                            .overlay(
                                TextField("Nama", text: $profileVM.selfUser.username)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelPrimary)
                                    .padding(.horizontal, 12)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.systemBlack, lineWidth: 1)
                            )
                    }
                    .padding(.bottom, 8)
//                    .onChange(of: profileVM.selfUser.username) { oldValue, newValue in
//                        profileVM.checkDisableButton()
//                        isButtonDisabled = profileVM.disableButton
//                    }
                    
                    Text("Nomor Handphone\(Text("*").foregroundStyle(.red))")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.labelPrimary)
                    
                    Rectangle()
                        .frame(width: 362, height: 32)
                        .foregroundStyle(.clear)
                        .overlay(
                            TextField("Nomor Handphone", text: $profileVM.selfUser.contactInfo)
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelPrimary)
                                .padding(.horizontal, 12)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.systemBlack, lineWidth: 1)
                        )
//                        .onChange(of: profileVM.selfUser.contactInfo) { oldValue, newValue in
//                            profileVM.checkDisableButton()
//                            isButtonDisabled = profileVM.disableButton
//                        }
                    
                    Text("Pastikan nomor handphone-mu terisi ya, agar orang yang ingin menerima pakaian bisa menghubungi mu~")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundStyle(.labelSecondary)
                        .padding(.bottom, 16)
                    
                    Text("Alamat\(Text("*").foregroundStyle(.red))")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.labelPrimary)
                    
                    Rectangle()
                        .frame(width: 362, height: 32)
                        .foregroundStyle(.clear)
                        .overlay(
                            HStack {
                                Text(profileVM.selfUser.address.isEmpty ? "Alamat Sekarang" : profileVM.selfUser.address)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelSecondary)
                                    .padding(.horizontal, 12)
                                Spacer()
                            }
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.systemBlack, lineWidth: 1)
                        )
                        .padding(.bottom, 16)
//                        .onChange(of: profileVM.selfUser.address) { oldValue, newValue in
//                            profileVM.checkDisableButton()
//                            isButtonDisabled = profileVM.disableButton
//                        }
                    
                    Text("Saran Pakaian untuk diambil\(Text("*").foregroundStyle(.red))")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.labelPrimary)
                    
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
//                    .onChange(of: qty) { oldValue, newValue in
//                        uploadVM.defaultCloth.quantity = qty
//                        uploadVM.checkFields()
//                    }
                    
                    Text("Jika penerima pakaian berkenan menerima seusai dengan saran, kasih dia freebies yuk~ ")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundStyle(.labelSecondary)
                    
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
                        CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Simpan", isButtonDisabled: $isButtonDisabled)
                    }
                }
            }
            .padding(.horizontal, 16)
            .onTapGesture {
                self.hideKeyboard()
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 12)
        .toolbar{
            ToolbarItem {
                Button{
                    Task{
                        do {
                            try await profileVM.deleteUserData(id: profileVM.selfUser.userID ?? "")
                            LocalUserDefaultRepository.shared.deleteUser()
                            navigationRouter.backToDiscovery()
                        } catch {
                            print("Failed to delete user data from CloudKit: \(error.localizedDescription)")
                        }
                    }
                } label: {
                    Text("Hapus")
                }
            }
        }
    }
}

//#Preview {
//    EditProfileView()
//}
