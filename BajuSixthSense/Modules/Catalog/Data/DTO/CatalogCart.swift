//
//  CatalogCart.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/11/24.
//

import Foundation

struct ClothOwner: Codable {
    var userID: String
    var username: String
    var contact: String
    var latitude: Double
    var longitude: Double
    var sugestedAmount: Int
}

struct CartData: Codable {
    var clothOwner: ClothOwner
    var clothItems: [String]
    
    init() {
        self.clothOwner = ClothOwner(
            userID: "",
            username: "",
            contact: "",
            latitude: -1.0,
            longitude: -1.0,
            sugestedAmount: -1
        )
        self.clothItems = [String]()
    }
    
    init(clothOwner: ClothOwner, clothItems: [String]) {
        self.clothOwner = clothOwner
        self.clothItems = clothItems
    }
}

extension ClothOwner {
    func mapToUserEntity() -> UserEntity {
        return UserEntity(
            userID: self.userID,
            username: self.username,
            contactInfo: self.contact,
            coordinate: (self.latitude, self.longitude),
            wardrobe: [],
            minimal: self.sugestedAmount
        )
    }
}

extension CartData {
    func mapFromEntity(catalog: CatalogDisplayEntity) -> CartData {
        var items = [String]()
        
        for item in catalog.clothes {
            guard let id = item.id else { continue }
            items.append(id)
        }
        
        return CartData(
            clothOwner: ClothOwner(
                userID: catalog.owner.userID ?? "",
                username: catalog.owner.username,
                contact: catalog.owner.contactInfo,
                latitude: catalog.owner.coordinate.lat,
                longitude: catalog.owner.coordinate.lon,
                sugestedAmount: catalog.owner.sugestedMinimal
            ),
            clothItems: items
        )
    }
}
