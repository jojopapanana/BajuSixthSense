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
    
    var formatter: NumberFormatter = NumberFormatter()
    
    @State var qty: Int?
    
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
                        // dummy text field
                            .overlay(
                                TextField("Nama", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelPrimary)
                                    .padding(.horizontal, 12)
                            )
                        // REALLLL
                        //                            .overlay(
                        //                                TextField(
                        //                                    text: $profileVM.selfUser.username,
                        //                                    prompt: Text("Required")
                        //                                ) {
                        //                                    Text(profileVM.selfUser.username)
                        //                                }
                        //                                .textInputAutocapitalization(.never)
                        //                                .autocorrectionDisabled(true)
                        //                            )
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
                    //dummy textfield
                        .overlay(
                            TextField("Nomor Handphone", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelPrimary)
                                .padding(.horizontal, 12)
                        )
                    // REALLLL
                    //                        .overlay(
                    //                            TextField(
                    //                                text: $profileVM.selfUser.contactInfo,
                    //                                prompt: Text("Required")
                    //                            ) {
                    //                                Text(profileVM.selfUser.contactInfo)
                    //                            }
                    //                            .textInputAutocapitalization(.never)
                    //                            .autocorrectionDisabled(true)
                    //                            .keyboardType(.numberPad)
                    //                        )
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
                                // dummy
                                Text("Alamat Sekarang")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelSecondary)
                                    .padding(.horizontal, 12)
                                // REAL
                                //                                Text(profileVM.selfUser.address.isEmpty ? "Current Location" : profileVM.selfUser.address)
                                //                                    .font(.subheadline)
                                //                                    .fontWeight(.regular)
                                //                                    .foregroundStyle(.labelSecondary)
                                //                                    .padding(.horizontal, 12)
                                Spacer()
                            }
                            //                                .onTapGesture {
                            //                                #warning("Pak PM blg nggk ush dulu")
                            //                                }
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
                                    let count = qty ?? 0
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
                                    let count = qty ?? 0
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
                    //                    .onChange(of: qty) { oldValue, newValue in
                    //                        uploadVM.defaultCloth.quantity = qty
                    //                        uploadVM.checkFields()
                    //                    }
                    
                    Text("Jika penerima pakaian berkenan menerima seusai dengan saran, kasih dia freebies yuk~ ")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundStyle(.labelSecondary)
                    
                    Spacer()
                    
                    //button
                    Button {
                        // save
                    } label: {
                        Rectangle()
                            .frame(width: 361, height: 50)
                            .cornerRadius(6)
                            .overlay(
                                Text("Simpan")
                                    .font(.subheadline)
                                    .foregroundStyle(.systemPureWhite)
                            )
                    }
                }
            }
            .padding(.horizontal, 16)
//            .onTapGesture {
//                self.hideKeyboard()
//            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditProfileView()
}
