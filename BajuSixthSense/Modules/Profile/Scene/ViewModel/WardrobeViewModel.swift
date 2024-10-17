//
//  WardrobeViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 16/10/24.
//

import Foundation

class WardrobeViewModel: ObservableObject {
    private let wardrobeUseCase = DefaultWardrobeUseCase()
    private let bookmarkUseCase = DefaultBookmarkUseCase()
    private let profileUseCase = DefaultProfileUseCase()
    @Published var wardrobeItems = [ClothEntity]()
    @Published var catalogItems = [CatalogItemEntity]()
    
    init() {
        fetchWardrobeItems()
    }
    
    init(id: String) {
        getUserWardrobeItem(id: id)
    }
    
    func fetchWardrobeItems() {
        self.wardrobeItems = wardrobeUseCase.fetchWardrobe()
    }
    
    func removeWardrobe(id: String?) throws {
        Task {
            guard let clothID = id else {
                throw ActionFailure.FailedAction
            }
            
            let result = await wardrobeUseCase.deleteCloth(clothID: clothID)
            
            if !result {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func updateWardrobe(cloth: ClothEntity) throws {
        Task {
            let result = await wardrobeUseCase.editCloth(cloth: cloth)
            
            if !result {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func updateClothStatus(clothId: String?, status: ClothStatus) throws {
        Task {
            guard let id = clothId else {
                throw ActionFailure.FailedAction
            }
            let result = await wardrobeUseCase.editClothStatus(clothID: id, clothStatus: status)
            
            if !result {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func getUserWardrobeItem(id: String) {
        Task {
            var items = [CatalogItemEntity]()
            
            guard let user = await profileUseCase.fetchUser(id: id) else {
                return
            }
            
            let retreiveItems = await wardrobeUseCase.getOtherUserWardrobe(userID: id)
            
            for item in retreiveItems {
                items.append(CatalogItemEntity.mapEntitty(cloth: item, owner: user))
            }
            
            self.catalogItems = items
        }
    }
}
