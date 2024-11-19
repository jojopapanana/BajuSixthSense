//
//  Utilities.swift
//  CloudKitTestProject
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation

enum RecordName: String {
//    case BulkCloth = "BulkCloth"
//    case User = "User"
    case UDUserSelf = "LocalUserSelf"
    case CartData = "CartData"
    case ClothItem = "ClothItem"
    case UserData = "UserData"
}

/*
 - ownerId
 - photo: CKAsset
 - clothName: String
 - deffect: [String]
 - description
 - price
 - status
 */

//enum BulkClothFields: String {
//    case OwnerID = "OwnerID"
//    case Photos = "Photos"
//    case Quantity = "Quantity"
//    case Categories = "Categories"
//    case AdditionalNotes = "AdditionalNotes"
//    case Status = "Status"
//}
//
//enum UserFields: String {
//    case Username = "Username"
//    case ContactInfo = "ContactInfo"
//    case Latitude = "Latitude"
//    case Longitude = "Longitude"
//    case Wardrobe = "Wardrobe"
//}

enum ClothItemField: String {
    case OwnerID = "OwnerID"
    case Photo = "Photo"
    case Defects = "Defects"
    case Color = "Color"
    case Category = "Category"
    case Description = "Description"
    case Price = "Price"
    case Status = "Status"
}

enum UserDataField: String {
    case Username = "Username"
    case ContactInfo = "ContactInfo"
    case Latitude = "Latitude"
    case Longitude = "Longitude"
    case Wardrobe = "Wardrobe"
    case SugestedMinimal = "SugestedMinimal"
}

enum ActionFailure: String, Error {
    case NilStringError = "[(-1)]: Nil String"
    case FailedAction = "[(-2)]: Failed Action"
    case NonRegisteredUser = "[-3]: User have not registered"
    case NoDataFound = "[-4]: No Data Found"
}

enum ClothType: String, CaseIterable {
    case TShirt = "T_Shirt"
    case Shirt = "Shirt"
    case Pants = "Pants"
    case Shorts = "Shorts"
    case Skirt = "Skirt"
    case Hoodie = "Hoodie"
    case Jacket = "Jacket"
    case Dress = "Dress"
    case Suit = "Suit"
    case Error = "Error"
    
    var getName: String {
        switch self {
        case .TShirt:
            return "Kaos"
        case .Shirt:
            return "Kemeja"
        case .Pants:
            return "Celana Panjang"
        case .Shorts:
            return "Celana Pendek"
        case .Skirt:
            return "Kaos"
        case .Hoodie:
            return "Hoodie"
        case .Jacket:
            return "Jaket"
        case .Dress:
            return "Dress"
        case .Suit:
            return "Jas Formal"
        case .Error:
            return "Error"
        }
    }
    
    static func assignType(type: String) -> ClothType {
        return ClothType.allCases.first(where: { $0.rawValue == type }) ?? .Error
    }
    
    static func fetchTypesArray() -> [String] {
        return ClothType.allCases.dropLast().map({$0.rawValue})
    }
}

enum ClothColor: String, CaseIterable {
    case Black = "Black"
    case Blue = "Blue"
    case Brown = "Brown"
    case Green = "Green"
    case Pink = "Pink"
    case Red = "Red"
    case Silver = "Silver"
    case White = "White"
    case Yellow = "Yellow"
    case Error = "Error"
    
    var getName: String {
        switch self {
        case .Black:
            return "Hitam"
        case .Blue:
            return "Biru"
        case .Brown:
            return "Coklat"
        case .Green:
            return "Hijau"
        case .Pink:
            return "Pink"
        case .Red:
            return "Merah"
        case .Silver:
            return "Silver"
        case .White:
            return "Putih"
        case .Yellow:
            return "Kuning"
        case .Error:
            return "Error"
        }
    }
    
    static func assignType(type: String) -> ClothColor {
        return ClothColor.allCases.first(where: { $0.rawValue == type }) ?? .Error
    }
    
    static func fetchTypesArray() -> [String] {
        return ClothColor.allCases.dropLast().map({$0.rawValue})
    }
}

enum ClothDefect: String, Identifiable, CaseIterable {
    case Lubang = "Lubang"
    case Noda = "Noda"
    case Pudar = "Pudar"
    case KancingHilang = "Kancing Hilang"
    case Error = "Error"
    
    var id: Int {
        switch self {
            case .Lubang:
                return 1
            case .Noda:
                return 2
            case .Pudar:
                return 3
            case .KancingHilang:
                return 4
            case .Error:
                return -1
        }
    }
    
    static func assignType(type: String) -> ClothDefect {
        return ClothDefect.allCases.first(where: { $0.rawValue == type }) ?? .Error
    }
    
    static func fetchTypesArray() -> [String] {
        return ClothDefect.allCases.dropLast().map({$0.rawValue})
    }
}

enum ClothStatus: String, CaseIterable {
    case Initial = "Initial"
    case Posted = "Posted"
    case Given = "Given"
    case Error = "Error"
    
    static func assignStatus(status: String) -> ClothStatus {
        return ClothStatus.allCases.first(where: { $0.rawValue == status }) ?? .Error
    }
    
    func getProfileButtonText() -> String {
        switch self {
            case .Initial:
                return "Continue"
            case .Posted:
                return "Mark as Given"
            case .Given:
                return "Mark as Posted"
            case .Error:
                return "Error"
        }
    }
}

enum ActionResult {
    case Initial
    case Success
    case Failure(Error)
}
