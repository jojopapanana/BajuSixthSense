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
        
        guard let id = user.userID else { return false }
        
        result = udRepo.save(user: user)
        result = await userRepo.update(id: id, param: user.mapToUserDTO())
        
        return result
    }
    
    func fetchSelfUser() -> LocalUserEntity {
        guard let user = udRepo.fetch() else {
            return LocalUserEntity(username: "Nil", contactInfo: "Nil", address: "Nil", coordinate: (0.0,0.0))
        }
        
        return user.mapToLocalUserEntity()
    }
}
