//
//  CatalogEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/10/24.
//

#warning("DEPRECATED")
//import Foundation
//import SwiftUI
//
//struct ItemOwnerEntity: Equatable {
//    var id: String?
//    var username: String
//    var contactInfo: String
//    var coordinate: (lat: Double, lon: Double)
//    
//    init(userID: String? = nil, username: String, contactInfo: String, coordinate: (lat: Double, lon: Double)) {
//        self.id = userID
//        self.username = username
//        self.contactInfo = contactInfo
//        self.coordinate = coordinate
//    }
//
//    static func == (lhs: ItemOwnerEntity, rhs: ItemOwnerEntity) -> Bool {
//        let id = lhs.id == rhs.id
//        let username = lhs.username == rhs.username
//        let contactInfo = lhs.contactInfo == rhs.contactInfo
//        let coordinate = lhs.coordinate == rhs.coordinate
//        
//        return id && username && contactInfo && coordinate
//    }
//}
//
//struct CatalogItemEntity: Identifiable, Equatable {
//    var id: String?
//    var owner: ItemOwnerEntity
//    var photos: [UIImage?]
//    var quantity: Int
//    var category: [ClothType]
//    var additionalNotes: String
//    var lastUpdated: Date
//    var status: ClothStatus
//    var distance: Double?
//    
//    init(clothID: String?, owner: ItemOwnerEntity, photos: [UIImage?], quantity: Int, category: [ClothType], additionalNotes: String, lastUpdated: Date, status: ClothStatus) {
//        self.id = clothID
//        self.owner = owner
//        self.photos = photos
//        self.quantity = quantity
//        self.category = category
//        self.additionalNotes = additionalNotes
//        self.lastUpdated = lastUpdated
//        self.status = status
//    }
//    
//    static func == (lhs: CatalogItemEntity, rhs: CatalogItemEntity) -> Bool {
//        let idCheck = lhs.id == rhs.id
//        let ownerCheck = lhs.owner == rhs.owner
//        let photosCheck = lhs.photos == rhs.photos
//        let quantityCheck = lhs.quantity == rhs.quantity
//        let categoryCheck = lhs.category == rhs.category
//        let additionalNotesCheck = lhs.additionalNotes == rhs.additionalNotes
//        
//        return idCheck && ownerCheck && photosCheck && quantityCheck && categoryCheck && additionalNotesCheck
//    }
//}
//
//extension CatalogItemEntity {
//    static func mapEntitty(cloth: ClothEntity, owner: UserEntity) -> CatalogItemEntity {
//        return CatalogItemEntity(
//            clothID: cloth.id,
//            owner: ItemOwnerEntity(
//                userID: owner.userID,
//                username: owner.username,
//                contactInfo: owner.contactInfo,
//                coordinate: (lat: owner.coordinate.lat, lon: owner.coordinate.lon)
//            ),
//            photos: cloth.photos,
//            quantity: cloth.quantity ?? 0,
//            category: cloth.category,
//            additionalNotes: cloth.additionalNotes,
//            lastUpdated: cloth.lastUpdated,
//            status: cloth.status
//        )
//    }
//    
//    func mapEntity() -> ClothEntity {
//        return ClothEntity(
//            clothID: self.id,
//            owner: self.owner.id ?? "nil",
//            photos: self.photos,
//            quantity: self.quantity,
//            category: self.category,
//            additionalNotes: self.additionalNotes,
//            lastUpdated: self.lastUpdated,
//            status: self.status)
//    }
//}
