//
//  CatalogEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/10/24.
//

import Foundation
import SwiftUI

struct ItemOwnerEntity {
    var id: String?
    var username: String
    var contactInfo: String
    var coordinate: (lat: Double, lon: Double)
    
    init(userID: String? = nil, username: String, contactInfo: String, coordinate: (lat: Double, lon: Double)) {
        self.id = userID
        self.username = username
        self.contactInfo = contactInfo
        self.coordinate = coordinate
    }
}

struct CatalogItemEntity: Identifiable {
    var id: String?
    var owner: ItemOwnerEntity
    var photos: [UIImage?]
    var quantity: Int
    var category: [ClothType]
    var additionalNotes: String
    var lastUpdated: Date
    var status: ClothStatus
    var distance: Double?
    
    init(clothID: String?, owner: ItemOwnerEntity, photos: [UIImage?], quantity: Int, category: [ClothType], additionalNotes: String, lastUpdated: Date, status: ClothStatus) {
        self.id = clothID
        self.owner = owner
        self.photos = photos
        self.quantity = quantity
        self.category = category
        self.additionalNotes = additionalNotes
        self.lastUpdated = lastUpdated
        self.status = status
    }
}

extension CatalogItemEntity {
    static func mapEntitty(cloth: ClothEntity, owner: UserEntity) -> CatalogItemEntity {
        return CatalogItemEntity(
            clothID: cloth.id,
            owner: ItemOwnerEntity(
                userID: owner.userID,
                username: owner.username,
                contactInfo: owner.contactInfo,
                coordinate: (lat: owner.coordinate.lat, lon: owner.coordinate.lon)
            ),
            photos: cloth.photos,
            quantity: cloth.quantity,
            category: cloth.category,
            additionalNotes: cloth.additionalNotes,
            lastUpdated: cloth.lastUpdated,
            status: cloth.status
        )
    }
}
