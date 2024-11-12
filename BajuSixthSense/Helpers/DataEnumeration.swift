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
    case Kaos = "Kaos"
    case Kemeja = "Kemeja"
    case Jaket = "Jaket"
    case Hoodie = "Hoodie"
    case Rok = "Rok"
    case CelenaPanjang = "Celena Panjang"
    case CelanaPendek = "Celana Pendek"
    case Error = "Error"
    
    static func assignType(type: String) -> ClothType {
        return ClothType.allCases.first(where: { $0.rawValue == type }) ?? .Error
    }
}

enum ClothColor: String, CaseIterable {
    case Hitam = "Hitam"
    case Putih = "Putih"
    case AbuAbu = "Abu-abu"
    case Merah = "Merah"
    case Coklat = "Coklat"
    case Kuning = "Kuning"
    case Hijau = "Hijau"
    case Biru = "Biru"
    case Ungu = "Ungu"
    case Pink = "Pink"
    case Error = "Error"
    
    static func assignType(type: String) -> ClothColor {
        return ClothColor.allCases.first(where: { $0.rawValue == type }) ?? .Error
    }
}

enum ClothDefect: String, CaseIterable {
    case Lubang = "Lubang"
    case Noda = "Noda"
    case Pudar = "Pudar"
    case KancingHilang = "Kancing Hilang"
    case Error = "Error"
    
    static func assignType(type: String) -> ClothDefect {
        return ClothDefect.allCases.first(where: { $0.rawValue == type }) ?? .Error
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
