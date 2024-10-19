//
//  BookmarkUseCase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/10/24.
//

import Foundation

protocol BookmarkUseCase {
    func updateBookMarkChanges(bookmarks: [String]) -> Bool
    func removeBookmark(bookmark: String) -> Bool
    func fetchBookmarkedClothes(bookmarks: [String]) async -> [CatalogItemEntity]
}

final class DefaultBookmarkUseCase: BookmarkUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    
    func updateBookMarkChanges(bookmarks: [String]) -> Bool {
        return udRepo.updateBookmark(bookmark: bookmarks)
    }
    
    func removeBookmark(bookmark: String) -> Bool {
        return udRepo.removeBookmarkItem(removedBookmark: bookmark)
    }
    
    func fetchBookmarkIds() -> [String] {
        guard let user = udRepo.fetch() else { return [] }
        return user.bookmarks
    }
    
    func fetchBookmarkedClothes(bookmarks: [String]) async -> [CatalogItemEntity] {
        var items = [CatalogItemEntity]()
        
        let retrievedClothes: [ClothEntity] = await withCheckedContinuation { continuation in
            clothRepo.fetchBySelection(ids: bookmarks) { results in
                guard let retrieveClothes = results else {
                    continuation.resume(returning: [ClothEntity]())
                    return
                }
                continuation.resume(returning: retrieveClothes)
            }
        }
        
        for cloth in retrievedClothes {
            let ownerID = cloth.owner
            
            if ownerID == "" {
                continue
            }
            
            guard let owner = await userRepo.fetchUser(id: ownerID) else {
                continue
            }
            
            items.append(CatalogItemEntity.mapEntitty(cloth: cloth, owner: owner))
        }
        
        return items
    }
}
