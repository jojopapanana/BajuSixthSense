//
//  BookmarkViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 16/10/24.
//

import Foundation

class BookmarkViewModel: ObservableObject {
    private let bookmarkUsecase = DefaultBookmarkUseCase()
    private let profileUsecase = DefaultProfileUseCase()
    var bookmarkedIds: [String]
    
    @Published var bookmarkedItems = [CatalogItemEntity]()
    
    init() {
        self.bookmarkedIds = bookmarkUsecase.fetchBookmarkIds()
        fetchBookmarkedItems()
    }
    
    func fetchBookmarkedItems() {
        Task {
            self.bookmarkedItems = await bookmarkUsecase.fetchBookmarkedClothes(bookmarks: self.bookmarkedIds)
        }
    }
    
    func removeBookmark(id: String) throws {
        let result = bookmarkedItems.firstIndex(where: {
            guard let clothId = $0.id else { return false }
            return clothId == id
        })
        
        guard let index = result else {
            throw ActionFailure.FailedAction
        }
        
        bookmarkedItems.remove(at: index)
        
        if !bookmarkUsecase.removeBookmark(bookmark: id) {
            throw ActionFailure.FailedAction
        }
    }
    
    func checkIsBookmark(catalogItem: CatalogItemEntity) -> Bool {
        let user = profileUsecase.fetchSelfData()
        let bookmark = user.bookmarks
        
        return bookmark.contains(where: {$0 == catalogItem.id})
    }
}
