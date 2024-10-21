//
//  ClothDTO.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit
import SwiftUI

struct ClothDTO {
    var ownerID: String?
    var photos: [CKAsset]?
    var quantity: Int?
    var categories: [String]?
    var additionalNotes: String?
    var status: String?
}

extension ClothDTO {
    func prepareRecord() -> CKRecord {
        let record = CKRecord(recordType: RecordName.BulkCloth.rawValue)
        record.setValue(self.ownerID, forKey: BulkClothFields.OwnerID.rawValue)
        record.setValue(self.photos, forKey: BulkClothFields.Photos.rawValue)
        record.setValue(self.quantity, forKey: BulkClothFields.Quantity.rawValue)
        record.setValue(self.categories, forKey: BulkClothFields.Categories.rawValue)
        record.setValue(self.additionalNotes, forKey: BulkClothFields.AdditionalNotes.rawValue)
        record.setValue(self.status, forKey: BulkClothFields.Status.rawValue)
        
        return record
    }
    
    static func mapToEntity(record: CKRecord) -> ClothEntity? {
        guard
            let id = record.recordID.recordName as? String,
            let ownerID = record.value(forKey: BulkClothFields.OwnerID.rawValue) as? String,
            let photos = record.value(forKey: BulkClothFields.Photos.rawValue) as? [CKAsset],
            let quantity = record.value(forKey: BulkClothFields.Quantity.rawValue) as? Int,
            let categories = record.value(forKey: BulkClothFields.Categories.rawValue) as? [String],
            let additionalNotes = record.value(forKey: BulkClothFields.AdditionalNotes.rawValue) as? String,
            let status = record.value(forKey: BulkClothFields.Status.rawValue) as? String
        else {
            print("failed to map record to entity")
            return nil
        }
        
        var images = [UIImage]()
        photos.forEach { asset in
            guard
                let url = asset.fileURL,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else { return }
            images.append(image)
        }
        
        var types = [ClothType]()
        categories.forEach { type in
            types.append(ClothType.assignType(type: type))
        }
        
        return ClothEntity(
            clothID: id,
            owner: ownerID,
            photos: images,
            quantity: quantity,
            category: types,
            additionalNotes: additionalNotes,
            lastUpdated: record.modificationDate ?? Date.now,
            status: ClothStatus.assignStatus(status: status)
        )
    }
}
