// 
//  UploadClothUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

protocol UploadClothUseCase {
    func saveNewCloth(cloth: ClothEntity) async throws
}

final class DefaultUploadClothUseCase: UploadClothUseCase {
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    let udRepo = LocalUserDefaultRepository.shared
    
    func saveNewCloth(cloth: ClothEntity) async throws {
        guard
            let user = udRepo.fetch(),
            let id = user.userID
        else {
            throw ActionFailure.NilStringError
        }
        
        var clothItem = cloth
        clothItem.owner = id
        
        let recordId = await clothRepo.save(param: clothItem.mapToDTO())
        do { try udRepo.addWardrobeItem(addedWardrobe: recordId) } catch {
            throw ActionFailure.FailedAction
        }
        
        guard
            let user = udRepo.fetch()
        else {
            throw ActionFailure.NilStringError
        }
        
        let updateResult = await userRepo.updateWardrobe(id: clothItem.owner, wardrobe: user.wardrobe)
        if !updateResult { throw ActionFailure.FailedAction }
    }
}
