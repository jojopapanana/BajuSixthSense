// 
//  ProfileViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private let profileUseCase = DefaultProfileUseCase()
    private let originalUser: LocalUserEntity
    
    @Published var selfUser: LocalUserEntity
    @Published var firstLetter: String = "?"
    @Published var disableButton = true
    
    init() {
        self.originalUser = profileUseCase.fetchSelfUser()
        self.selfUser = profileUseCase.fetchSelfUser()
        setFirstLetter()
    }

    func updateUser() throws {
        Task {
            let result = await profileUseCase.updateProfile(profile: self.selfUser)
            
            if !result {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func setFirstLetter() {
        self.firstLetter = selfUser.username.first?.uppercased() ?? "?"
    }
    
    func getFirstLetter(items: [CatalogItemEntity]?) -> String {
        if items == nil {
            return self.firstLetter
        }
        
        guard
            let item = items?.first
        else {
            return self.firstLetter
        }
        
        return item.owner.username.first?.uppercased() ?? "?"
    }
    
    func getUsername(items: [CatalogItemEntity]?) -> String {
        if items == nil {
            return self.selfUser.username
        }
        
        guard
            let item = items?.first
        else {
            return self.selfUser.username
        }
        
        return item.owner.username
    }
    
    func getDistance(items: [CatalogItemEntity]?) -> Double {
        if items == nil {
            return -1
        }
        
        guard
            let item = items?.first
        else {
            return -1
        }
        
        return item.distance ?? -1
    }
    
    func checkDisableButton() {
        let checkName = selfUser.username == originalUser.username || selfUser.username.isEmpty
        let checkContact = selfUser.contactInfo == originalUser.contactInfo || selfUser.contactInfo.isEmpty
        let checkAddress = selfUser.address == originalUser.address || selfUser.address.isEmpty
        let checkCoordinate = selfUser.coordinate == originalUser.coordinate
        
        self.disableButton = checkName && checkContact && checkAddress && checkCoordinate
    }
    
    func checkSelfUser(id: String) -> Bool {
        let user = profileUseCase.fetchSelfUser()
        
        if user.userID == id {
            return true
        } else {
            return false
        }
    }
}

