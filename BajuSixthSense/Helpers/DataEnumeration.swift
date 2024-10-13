//
//  Utilities.swift
//  CloudKitTestProject
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation

enum RecordName: String {
    case BulkCloth = "BulkCloth"
    case User = "User"
    case UDUserSelf = "LocalUserSelf"
}

enum BulkClothFields: String {
    case OwnerID = "OwnerID"
    case Photos = "Photos"
    case Quantity = "Quantity"
    case Categories = "Categories"
    case AdditionalNotes = "AdditionalNotes"
    case Status = "Status"
}

enum UserFields: String {
    case Username = "Username"
    case ContactInfo = "ContactInfo"
    case Region = "Region"
    case Location = "Location"
    case Wardrobe = "Wardrobe"
}

enum DataError: String {
    case NilStringError = "[(-1)]: Nil String"
}

enum ClothType: String, CaseIterable {
    // Placeholder
    case Shirt = "Shirt"
    case Pants = "Pants"
    case Jacket = "Jacker"
    case Hat = "Hat"
    case Shoes = "Shoes"
    case Error = "Error"
    
    static func assignType(type: String) -> ClothType {
        return ClothType.allCases.first(where: { $0.rawValue == type }) ?? .Error
    }
    
}

enum ClothStatus: String, CaseIterable {
    // Placeholder
    case Available = "Available"
    case Rented = "Rented"
    case Damaged = "Damaged"
    case Lost = "Lost"
    case Error = "Error"
    
    static func assignStatus(status: String) -> ClothStatus {
        return ClothStatus.allCases.first(where: { $0.rawValue == status }) ?? .Error
    }
}
