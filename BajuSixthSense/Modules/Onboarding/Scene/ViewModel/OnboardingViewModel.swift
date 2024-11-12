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
    @Published var statusReceived = false
    
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
        let result = await locationManager.getUserCoordinates(location: self.location)
        await MainActor.run {
            self.user.latitude = result.latitude
            self.user.longitude = result.longitude
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
//        let statusReceived = self.locationStatusReceived
        
        return usernameFilled && contactInfoFilled && self.statusReceived
    }
}
