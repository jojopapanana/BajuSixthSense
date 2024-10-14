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
    case Shirt = "Shirt"
    case TShirt = "T-Shirt"
    case Sweater = "Sweater"
    case Hoodies = "Hoodies"
    case LongPants = "Long Pants"
    case Skirts = "Skirts"
    case Shorts = "Shorts"
    case Jacket = "Jacket"
    case Error = "Error"
    
    static func assignType(type: String) -> ClothType {
        return ClothType.allCases.first(where: { $0.rawValue == type }) ?? .Error
    }
    
}

enum ClothStatus: String, CaseIterable {
    case Draft = "Draft"
    case Posted = "Posted"
    case Given = "Given"
    case Error = "Error"
    
    static func assignStatus(status: String) -> ClothStatus {
        return ClothStatus.allCases.first(where: { $0.rawValue == status }) ?? .Error
    }
}
