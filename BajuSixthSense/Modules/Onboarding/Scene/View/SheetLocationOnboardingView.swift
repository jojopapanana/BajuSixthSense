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
    @StateObject var vm: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                
                Image("LocationOnboardingAsset")
                    .padding(.bottom, 65)
                
                Spacer()
            }
            
            Text("We need your permission to access location")
                .font(.title)
                .bold()
                .padding(.bottom, 9)
            
            Text("We need your location to show how far bulk items are from you. This helps you find what’s closest, saving time and effort.")
                .font(.subheadline)
                .foregroundStyle(Color.labelSecondary)
                .padding(.bottom, 16)
            
            Text("Tip: Using your house location is ideal, makes it easier to find bulk items near where you are staying")
                .font(.subheadline)
                .foregroundStyle(Color.labelSecondary)
            
            Spacer()
            
            HStack{
                Spacer()
                
                Button{
                    Task{
                        let result = await vm.locationManager.makeLocationRequest()
                        if result {
                            RiveViewModel(fileName: "shellyloading-4").view()
                            vm.location = await vm.fetchUserLocation()
                            print("Fetched Location: \(vm.location.coordinate.latitude), \(vm.location.coordinate.longitude)")
                            userAddress = await vm.locationManager.lookUpCurrentLocation(location: vm.location) ?? "Failed getting location"
                        }
                        
                        vm.statusReceived = true
                        showSheet.toggle()
                    }
                } label: {
                    CustomButtonView(buttonType: .primary, buttonWidth: 360, buttonLabel: "Allow Location Access", isButtonDisabled: $isButtonDisabled)
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
