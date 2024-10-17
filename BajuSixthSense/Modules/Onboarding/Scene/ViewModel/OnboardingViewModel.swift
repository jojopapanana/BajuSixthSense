//
//  OnboardingViewModel.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 17/10/24.
//

import Foundation
import CoreLocation

class OnboardingViewModel: ObservableObject{
//    @Published var userLocation: CLLocation?
    
    let locationManager = LocationManager()
    
    func fetchUserLocation() async -> CLLocation {
        var userLocation = CLLocation(latitude: 0, longitude: 0)
        do {
            userLocation = try await locationManager.getCurrentLocation()
        } catch {
            print("error in retrieving user location, \(error.localizedDescription)")
        }
        
        return userLocation
    }
}
