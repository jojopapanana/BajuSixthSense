// 
//  ProfileViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private let profileUseCase = DefaultProfileUseCase()
    private var originalUser: LocalUserEntity
    
    @Published var selfUser: LocalUserEntity
    @Published var firstLetter: String = "?"
    @Published var disableButton = true
    
    init() {
        do {
            self.originalUser = try profileUseCase.fetchSelfUser()
            self.selfUser = try profileUseCase.fetchSelfUser()
        } catch {
            print("error: \(error.localizedDescription)")
            self.originalUser = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0), sugestedMinimal: 0)
            self.selfUser = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0), sugestedMinimal: 0)
        }
        
        setFirstLetter()
    }

    func updateUser() throws {
        Task {
            do {
                try await profileUseCase.updateProfile(profile: self.selfUser)
            } catch {
                throw ActionFailure.FailedAction
            }
            
            setFirstLetter()
        }
    }
    
    func setFirstLetter() {
        self.firstLetter = selfUser.username.first?.uppercased() ?? "?"
    }
    
    func getFirstLetter(item: CatalogDisplayEntity) -> String {
        return item.owner.username.first?.uppercased() ?? "?"
    }
    
    func getUsername(item: CatalogDisplayEntity) -> String {
        return item.owner.username
    }
    
    func getDistance(item: CatalogDisplayEntity) -> Double {
        return item.distance ?? -1
    }
    
    func checkDisableButton() {
        let checkName = selfUser.username == originalUser.username || selfUser.username.isEmpty
        let checkContact = selfUser.contactInfo == originalUser.contactInfo || selfUser.contactInfo.isEmpty
        let checkAddress = selfUser.address == originalUser.address || selfUser.address.isEmpty
        let checkCoordinate = selfUser.coordinate == originalUser.coordinate
        let checkSuggestedMinimal = selfUser.sugestedMinimal == originalUser.sugestedMinimal
        
        self.disableButton = checkName && checkContact && checkAddress && checkCoordinate && checkSuggestedMinimal
    }
    
    func checkSelfUser(id: String) -> Bool {
        var user = LocalUserEntity(username: "", contactInfo: "", coordinate: (0.0, 0.0), sugestedMinimal: 0)
        
        do {
            user = try profileUseCase.fetchSelfUser()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        if user.userID == id {
            return true
        } else {
            return false
        }
    }
}

