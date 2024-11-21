//
//  PhotoGuideView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 09/11/24.
//

import SwiftUI

struct PhotoGuideView: View {
    @State private var isShowAgainChecked = false
    @State private var isButtonDisabled = false
    @Binding var isSheetShowing: Bool
    @Binding var showGuideAgain: Bool
    
    let udRepo = LocalUserDefaultRepository.shared
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Petunjuk Pengambilan Foto")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button{
                    isSheetShowing = false
                } label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.vibrantSecondaryLabel, .vibrantTertiaryFills)
                }
            }
            .padding(.bottom, 30)
            
            HStack{
                Image("Illusiconguide1")
                    .resizable()
                    .frame(width: 35, height: 30)
                
                VStack(alignment: .leading){
                    Text("Pakaian terfoto dengan jelas")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Pastikan pakaianmu terlihat jelas, hasilnya makin estetik")
                        .font(.footnote)
                        .foregroundStyle(.labelBlack400)
                }
            }
            
            HStack{
                Image("ilusiconguide2")
                    .resizable()
                    .frame(width: 35, height: 35)
                
                VStack(alignment: .leading){
                    Text("Gunakan background kontras")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Pilih background yang kontras dengan  pakaianmu biar pakaianmu lebih standout")
                        .font(.footnote)
                        .foregroundStyle(.labelBlack400)
                }
            }
            .padding(.top, 30)
            
            HStack{
                Image("Ilusiconguide3")
                
                VStack(alignment: .leading){
                    Text("Pakaian masuk ke dalam frame")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Usahakan seluruh pakaian masuk ke dalam foto, jangan ada yang terpotong ya")
                        .font(.footnote)
                        .foregroundStyle(.labelBlack400)
                }
            }
            .padding(.top, 30)
            
            HStack{
                Image("Ilusiconguide4")
                
                VStack(alignment: .leading){
                    Text("1 foto 1 baju")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Potret pakaiannya satu per satu, biar makin simpel")
                        .font(.footnote)
                        .foregroundStyle(.labelBlack400)
                }
            }
            .padding(.top, 30)
            
            Toggle(isOn: $isShowAgainChecked) {
                Text("Jangan tampilkan lagi")
            }
            .onTapGesture {
                isShowAgainChecked = true
            }
            .toggleStyle(CheckboxToggleStyle())
            .padding([.top, .bottom], 30)
                    
            Button{
                do{
                    try udRepo.saveGuideSetting(willShowAgain: !isShowAgainChecked)
                    showGuideAgain = LocalUserDefaultRepository.shared.fetch()?.guideShowing ?? false
                } catch {
                    print("Error in saving setting")
                    return
                }
                
                isSheetShowing = false
                #warning("TO-DO: navigate to camera page")
            } label: {
                CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Selanjutnya", isButtonDisabled: $isButtonDisabled)
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    PhotoGuideView()
//}
