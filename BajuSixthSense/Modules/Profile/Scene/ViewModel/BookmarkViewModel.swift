//
//  BookmarkViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 16/10/24.
//

import Foundation

class BookmarkViewModel: ObservableObject {
    private let bookmarkUsecase = DefaultBookmarkUseCase()
    static private let profileUsecase = DefaultProfileUseCase()
    var bookmarkedIds: [String]
    
    @Published var bookmarkedItems = [CatalogItemEntity]()
    
    init() {
        self.bookmarkedIds = bookmarkUsecase.fetchBookmarkIds()
        fetchBookmarkedItems()
    }
    
    func fetchBookmarkedItems() {
        Task {
            let items = await bookmarkUsecase.fetchBookmarkedClothes(bookmarks: self.bookmarkedIds)
            DispatchQueue.main.async {
                self.bookmarkedItems = items
            }
        }
    }
    
    func removeBookmark(id: String?) throws {
        guard let clothid = id else {
            throw ActionFailure.NilStringError
        }
        
        let result = bookmarkedItems.firstIndex(where: {
            guard let clothId = $0.id else { return false }
            return clothId == id
        })
        
        guard let index = result else {
            throw ActionFailure.FailedAction
        }
        
        bookmarkedItems.remove(at: index)
        
        if !bookmarkUsecase.removeBookmark(bookmark: clothid) {
            throw ActionFailure.FailedAction
        }
    }
    
    static func checkIsBookmark(catalogItem: CatalogItemEntity) -> Bool {
        let user = profileUsecase.fetchSelfData()
        let bookmark = user.bookmarks
        
        return bookmark.contains(where: {$0 == catalogItem.id})
    }
}
