//
//  CatalogDisplayEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/11/24.
//

import Foundation

struct CatalogDisplayEntity: Identifiable, Equatable {
    var id = UUID()
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

extension CatalogDisplayEntity {
    func generatePriceRange() -> String {
        let lowest = self.lowestPrice ?? 0
        let highest = self.highestPrice ?? 0
        
        let lowestString = lowest == 0 ? "Rp0" : "Rp\(lowest)k"
        let highestString = "Rp\(highest)k"
        
        if lowest != highest {
            return "\(lowestString) - \(highestString)"
        } else {
            return lowest == 0 ? "Gratis" : highestString
        }
    }
    
    func mapToCartData() -> CartData {
        var clothIDs = [String]()
        
        for item in self.clothes {
            guard let id = item.id else { continue }
            clothIDs.append(id)
        }
        
        return CartData(
            clothOwner: self.owner.mapToClothOwner(),
            clothItems: clothIDs
        )
    }
}
