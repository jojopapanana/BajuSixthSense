// 
//  ProfileUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

protocol ProfileUseCase {
    func updateProfile(profile: LocalUserEntity) -> Bool
}

final class DefaultProfileUseCase: ProfileUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    
    func updateProfile(profile: LocalUserEntity) -> Bool {
        guard var user = udRepo.fetch() else { return false }
        user.username = profile.username
        user.contactInfo = profile.contactInfo
        user.address = profile.address
        user.latitude = profile.coordinate.lat
        user.longitude = profile.coordinate.lon
        user.regions = profile.regions
        
        return udRepo.save(user: user)
    }
    
    /*
     - update profile (Edit Profile) -> UserRepo & LocalUserRepo
     */
}
