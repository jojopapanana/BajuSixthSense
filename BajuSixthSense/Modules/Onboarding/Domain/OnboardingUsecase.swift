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
        let userID = await userRepo.save(param: user.mapToUserDTO())
        
        let result = udRepo.save(user: user)
        
        print(userID)
        
        if !result {
            throw ActionFailure.FailedAction
        }
    }
}
