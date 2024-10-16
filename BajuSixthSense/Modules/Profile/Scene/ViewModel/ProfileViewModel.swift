// 
//  ProfileViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

class ProfileViewModel {
    private let profileUseCase = DefaultProfileUseCase()
    private let selfUser: LocalUserEntity
    
    init() {
        self.selfUser = profileUseCase.fetchSelfUser()
    }
}

