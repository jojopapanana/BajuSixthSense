//
//  SheetLocationOnboardingView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 14/10/24.
//

import SwiftUI
import CoreLocation
import RiveRuntime

struct SheetLocationOnboardingView: View {
    @Binding var showSheet: Bool
    @Binding var userAddress: String
    @State private var isButtonDisabled = false
    @State private var isButtonClicked = false
    @StateObject var vm: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                
                if(isButtonClicked){
                    RiveViewModel(fileName: "shellyloading-4").view()
                        .frame(width: 300, height: 300)
                        .padding(.bottom, 65)
                } else {
                    Image("locationshelly")
                        .padding(.bottom, 65)
                }
                    
                
                Spacer()
            }
            
            Text("Kami membutuhkan izinmu untuk mengakses lokasi")
                .font(.title)
                .bold()
                .padding(.bottom, 9)
            
            
            Text("Kami perlu mengetahui seberapa jauh baju-baju yang ada darimu. Hal ini membantu kami mencarikan yang terdekat, mempersingkat waktu dan usaha.")
                .font(.subheadline)
                .foregroundStyle(Color.labelSecondary)
                .padding(.bottom, 16)
            
            
            Text("Tip: Menggunakan lokasi rumahmu adalah yang ideal, memudahkanmu untuk mencari baju-baju yang terdekat")
                .font(.subheadline)
                .foregroundStyle(Color.labelSecondary)
            
            
            Spacer()
            
            HStack{
                Spacer()
                
                Button{
                    Task{
                        let result = await vm.locationManager.makeLocationRequest()
                        if result {
                            vm.location = await vm.fetchUserLocation()
                            print("Fetched Location: \(vm.location.coordinate.latitude), \(vm.location.coordinate.longitude)")
                            userAddress = await vm.locationManager.lookUpCurrentLocation(location: vm.location) ?? "Failed getting location"
                        }
                        
                        vm.statusReceived = true
                        showSheet.toggle()
                    }
                    
                    isButtonClicked = true
                } label: {
                    CustomButtonView(buttonType: .primary, buttonWidth: 360, buttonLabel: "Izinkan Akses Lokasi", isButtonDisabled: $isButtonDisabled)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .rotationEffect(.degrees(45))
                        .foregroundStyle(Color.systemPurple)
                }
            }
        }
        .padding(.top, 11)
    }
}

//#Preview {
//    SheetLocationOnboardingView()
//}
