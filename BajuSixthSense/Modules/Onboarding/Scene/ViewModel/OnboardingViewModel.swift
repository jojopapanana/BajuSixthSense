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
    @Published var location = CLLocation(latitude: 0, longitude: 0)
    
    init() { }
    
    func fetchUserLocation() async -> CLLocation {
        var userLocation = CLLocation(latitude: 0, longitude: 0)
        
        if locationManager.checkAuthorization() {
            do {
                userLocation = try await locationManager.getCurrentLocation()
            } catch {
                print("error in retrieving user location, \(error.localizedDescription)")
            }
        } else {
            print("Try again")
        }
        
        return userLocation
    }

    func registerUser() async throws {
        let result = await locationManager.getUserCoordinates(location: self.location)
        await MainActor.run {
            self.user.latitude = result.latitude
            self.user.longitude = result.longitude
        }
        
        guard user.latitude != 0, user.longitude != 0 else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Location not set"])
        }
        
        do {
            try await onboardingUsecase.register(user: self.user)
            print("Registration successful")
        } catch {
            throw error
        }
    }
    
    func checkDataAvail() -> Bool {
        let usernameFilled = !user.username.isEmpty
        let contactInfoFilled = !user.contactInfo.isEmpty
//        let addressFilled = !user.address.isEmpty
        
        return usernameFilled && contactInfoFilled
    }
}
