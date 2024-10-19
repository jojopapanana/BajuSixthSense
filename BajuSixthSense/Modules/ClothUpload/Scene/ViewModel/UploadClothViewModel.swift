// 
//  UploadClothViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import SwiftUI

class UploadClothViewModel: ObservableObject {
    private let uploadUsecase = DefaultUploadClothUseCase()
    private let editUseCase = DefaultWardrobeUseCase()
    
    @Published var defaultCloth: ClothEntity
    @Published var disablePrimary = true
    @Published var disableSecondary = true
    
    init(defaultCloth: ClothEntity = ClothEntity()) {
        self.defaultCloth = defaultCloth
    }
    
    func uploadCloth() throws {
        Task {
            checkClothStatus()
            
            let result = await uploadUsecase.saveNewCloth(cloth: defaultCloth)
            
            if result == ActionFailure.NilStringError.rawValue {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func checkClothStatus() {
        DispatchQueue.main.async {
            if !self.disablePrimary {
                self.defaultCloth.status = .Posted
            } else {
                self.defaultCloth.status = .Draft
            }
        }
    }
    
    func updateCloth() throws {
        Task {
            let result = await editUseCase.editCloth(cloth: defaultCloth)
            
            if !result {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func deleteCloth() throws {
        Task {
            guard let clothID = defaultCloth.id else {
                throw ActionFailure.NilStringError
            }
            
            let result = await editUseCase.deleteCloth(clothID: clothID)
            
            if !result {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func fetchPhoto() -> [UIImage?] {
        return defaultCloth.photos
    }
    
    func addClothImage(image: UIImage?) {
        defaultCloth.photos.append(image)
        checkFields()
        print(defaultCloth.photos.count)
    }
    
    func removeImage(index: Int) {
        defaultCloth.photos.remove(at: index)
        checkFields()
        print(defaultCloth.photos.count)
    }
    
    func checkCategory(type: ClothType) -> Bool {
        if defaultCloth.category.contains(type) {
            return true
        } else {
            return false
        }
    }
    
    func addCategoryType(type: ClothType) {
        defaultCloth.category.append(type)
        checkFields()
    }
    
    func removeCategoryType(type: ClothType) {
        guard let index = defaultCloth.category.firstIndex(of: type) else {
            return
        }
        
        defaultCloth.category.remove(at: index)
        checkFields()
    }
    
    func fetchClothType() -> [ClothType] {
        return ClothType.allCases.dropLast()
    }
    
    func allFieldFilled() {
        let photoStatus = defaultCloth.photos.isEmpty
        let quantityStatus = defaultCloth.quantity == nil || (defaultCloth.quantity ?? 0) == 0
        let typeStatus = defaultCloth.category.isEmpty
        
        disablePrimary = photoStatus || quantityStatus || typeStatus
    }
    
    func anyFieldFilled() {
        let photoStatus = defaultCloth.photos.isEmpty
        let quantityStatus = defaultCloth.quantity == nil || (defaultCloth.quantity ?? 0) == 0
        let typeStatus = defaultCloth.category.isEmpty
        
        disableSecondary = photoStatus && quantityStatus && typeStatus
    }

    func checkFields() {
        allFieldFilled()
        anyFieldFilled()
    }
}
