//
//  WardrobeViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 16/10/24.
//

import Foundation

class WardrobeViewModel: ObservableObject {
    private let wardrobeUseCase = DefaultWardrobeUseCase()
    private let bookmarkUseCase = DefaultFavoriteUseCase()
    private let profileUseCase = DefaultProfileUseCase()
    private var wardrobeItems = [ClothEntity]()
    
    @Published var draftItems = [ClothEntity]()
    @Published var postedItems = [ClothEntity]()
//    @Published var catalogItems = [CatalogItemEntity]()
    
    init() {
        Task {
            await fetchWardrobeItems()
            distributeWardrobe()
        }
    }
    
    init(id: String) {
        getUserWardrobeItem(id: id)
    }
    
    func fetchWardrobeItems() async {
        wardrobeItems = await wardrobeUseCase.fetchWardrobe()
    }
    
    func distributeWardrobe() {
//        DispatchQueue.main.async {
//            self.draftItems = self.wardrobeItems.filter { item in
//                return item.status == .Draft
//            }
//            self.postedItems = self.wardrobeItems.filter { item in
//                return item.status == .Posted || item.status == .Given
//            }
//        }

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
            
            guard let index = self.postedItems.firstIndex(where: { $0.id == clothID }) else { return }
            DispatchQueue.main.async {
                self.postedItems.remove(at: index)
            }
            distributeWardrobe()
        }
    }
    
    func updateWardrobe(cloth: ClothEntity) throws {
        Task {
            let result = await wardrobeUseCase.editCloth(cloth: cloth)
            
            if !result {
                throw ActionFailure.FailedAction
            }
            
            distributeWardrobe()
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
            
            distributeWardrobe()
        }
    }
    
    func getUserWardrobeItem(id: String) {
//        Task {
//            var items = [CatalogItemEntity]()
//            
//            guard let user = await profileUseCase.fetchUser(id: id) else {
//                return
//            }
//            
//            let retreiveItems = await wardrobeUseCase.getOtherUserWardrobe(userID: id)
//            
//            for item in retreiveItems {
//                items.append(CatalogItemEntity.mapEntitty(cloth: item, owner: user))
//            }
//            
//            self.catalogItems = items
//        }
    }
    
//    func mapCatalogItemSelf(cloth: ClothEntity) -> CatalogItemEntity {
//        var user: UserEntity
//        
//        do {
//            let selfUser = try profileUseCase.fetchSelfUser()
//            user = selfUser.mapToUser()
//        } catch {
//            user = UserEntity(userID: "", username: "", contactInfo: "", coordinate: (0.0, 0.0), wardrobe: [])
//        }
//        
//        return CatalogItemEntity.mapEntitty(cloth: cloth, owner: user)
//    }
    
//    func getItems(status: ClothStatus) -> [ClothEntity] {
//        return status == .Initial ? self.draftItems : self.postedItems
//    }
}
