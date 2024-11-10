//
//  OnboardingUsecase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 18/10/24.
//

import Foundation

protocol OnboardingUsecase {
    func register(user: LocalUserDTO) async throws
}

class DefaultOnboardingUsecase: OnboardingUsecase {
    let userRepo = UserRepository()
    let udRepo = LocalUserDefaultRepository()
    
    func register(user: LocalUserDTO) async throws {
        var user = user
        
        let userID = await userRepo.save(param: user.mapToUserDTO())
        user.userID = userID
        let result = udRepo.save(user: user)
        
        if !result {
            throw ActionFailure.FailedAction
        }
    }
}
