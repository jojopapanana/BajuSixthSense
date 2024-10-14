//
//  SampleLocationView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 13/10/24.
//

import SwiftUI
import CoreLocation

struct SampleLocationView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var currentLocation : CLLocation?
    @State private var distance : Double?
    private let otherLocation = CLLocation(latitude: -6.3052, longitude: 106.6432)
    
    var body: some View {
        VStack{
            Text(locationManager.addressName ?? "Location not found")
            
            Button {
                Task { await self.updateLocation() }
            } label: {
                Text("Get Location")
            }
            
            Text("current location's coordinate: \(currentLocation?.coordinate)")
            
            Button {
                Task { await self.updateLocation() }
            } label: {
                Text("Get Location")
            }
        }
        .task {
            locationManager.checkAuthorization()
        }
    }
    
    func updateLocation() async {
        do {
            self.currentLocation = try await locationManager.currentLocation
        } catch {
            print("Could not get user location: \(error.localizedDescription)")
        }
    }
}

#Preview {
    SampleLocationView()
}
