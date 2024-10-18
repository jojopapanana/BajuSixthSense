//
//  OnboardingViewModel.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 17/10/24.
//

import Foundation
import CoreLocation

class OnboardingViewModel: ObservableObject {
    let locationManager = LocationManager()
    let onboardingUsecase = DefaultOnboardingUsecase()
    
    @Published var user = LocalUserDTO()
    
    init() { }
    
    func fetchUserLocation() async -> CLLocation {
        var userLocation = CLLocation(latitude: 0, longitude: 0)
        do {
            userLocation = try await locationManager.getCurrentLocation()
        } catch {
            print("error in retrieving user location, \(error.localizedDescription)")
        }
        
        return userLocation
    }

    func registerUser() async throws {
        do {
            try await onboardingUsecase.register(user: self.user)
        } catch {
            throw error
        }
    }
    
    func checkDataAvail() -> Bool {
        let usernameFilled = !user.username.isEmpty
        let contactInfoFilled = !user.contactInfo.isEmpty
        let addressFilled = !user.address.isEmpty
        
        return usernameFilled && contactInfoFilled && addressFilled
    }
}
