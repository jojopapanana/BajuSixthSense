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
    case Location = "Location"
    case Wardrobe = "Wardrobe"
    case WishList = "WishList"
    
}
