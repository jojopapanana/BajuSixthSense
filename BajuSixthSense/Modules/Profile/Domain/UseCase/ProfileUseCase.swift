// 
//  ProfileUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

protocol ProfileUseCase {
    func updateProfile(profile: LocalUserEntity) async -> Bool
}

final class DefaultProfileUseCase: ProfileUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    let userRepo = UserRepository.shared
    
    func updateProfile(profile: LocalUserEntity) async -> Bool {
        var result = false
        
        guard var user = udRepo.fetch() else { return false }
        user.username = profile.username
        user.contactInfo = profile.contactInfo
        user.address = profile.address
        user.latitude = profile.coordinate.lat
        user.longitude = profile.coordinate.lon
        user.regions = profile.regions
        
        guard let id = user.userID else { return false }
        
        result = udRepo.save(user: user)
        result = await userRepo.update(id: id, param: user.mapToUserDTO())
        
        return result
    }
    
    /*
     - update profile (Edit Profile) -> UserRepo & LocalUserRepo
     */
}
