//
//  CatalogDisplayEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/11/24.
//

import Foundation

struct CatalogDisplayEntity: Equatable {
    var owner: UserEntity
    var distance: Double?
    var clothes: [ClothEntity]
    var lowestPrice: Int?
    var highestPrice: Int?
    
    static func == (lhs: CatalogDisplayEntity, rhs: CatalogDisplayEntity) -> Bool {
        let ownerCheck = lhs.owner == rhs.owner
        let distanceCheck = lhs.distance == rhs.distance
        let clothesCheck = lhs.clothes == rhs.clothes
        let lowestPriceCheck = lhs.lowestPrice == rhs.lowestPrice
        let highestPriceCheck = lhs.highestPrice == rhs.highestPrice
        
        return ownerCheck && distanceCheck && clothesCheck && lowestPriceCheck && highestPriceCheck
    }
    
    init(
        owner: UserEntity,
        distance: Double?,
        clothes: [ClothEntity],
        lowestPrice: Int?,
        highestPrice: Int?
    ) {
        self.owner = owner
        self.distance = distance
        self.clothes = clothes
        self.lowestPrice = lowestPrice
        self.highestPrice = highestPrice
    }
}
