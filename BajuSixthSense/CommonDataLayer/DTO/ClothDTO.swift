//
//  ClothDTO.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit
import SwiftUI

/*
 - ownerId
 - photo: CKAsset
 - clothName: String
 - deffect: [String]
 - description
 - price
 - status
 */

struct ClothDTO {
    var ownerID: String?
    var photo: CKAsset?
    var defects: [String]?
    var color: String?
    var category: String?
    var description: String?
    var price: Int?
    var status: String?
}

extension ClothDTO {
    func prepareRecord() -> CKRecord {
        let record = CKRecord(recordType: RecordName.ClothItem.rawValue)
        record.setValue(self.ownerID, forKey: ClothItemField.OwnerID.rawValue)
        record.setValue(self.photo, forKey: ClothItemField.Photo.rawValue)
        record.setValue(self.defects, forKey: ClothItemField.Defects.rawValue)
        record.setValue(self.color, forKey: ClothItemField.Color.rawValue)
        record.setValue(self.category, forKey: ClothItemField.Category.rawValue)
        record.setValue(self.description, forKey: ClothItemField.Description.rawValue)
        record.setValue(self.price, forKey: ClothItemField.Price.rawValue)
        record.setValue(self.status, forKey: ClothItemField.Status.rawValue)
        
        return record
    }
    
    static func mapToEntity(record: CKRecord) -> ClothEntity? {
        guard
            let id = record.recordID.recordName as? String,
            let ownerID = record.value(forKey: ClothItemField.OwnerID.rawValue) as? String,
            let photo = record.value(forKey: ClothItemField.Photo.rawValue) as? CKAsset,
            let defects = record.value(forKey: ClothItemField.Defects.rawValue) as? [String],
            let color = record.value(forKey: ClothItemField.Color.rawValue) as? String,
            let category = record.value(forKey: ClothItemField.Category.rawValue) as? String,
            let description = record.value(forKey: ClothItemField.Description.rawValue) as? String,
            let price = record.value(forKey: ClothItemField.Price.rawValue) as? Int,
            let status = record.value(forKey: ClothItemField.Status.rawValue) as? String
        else {
            print("failed to map record to entity")
            return nil
        }
        
        var clothDefects = [ClothDefect]()
        defects.forEach { defect in
            clothDefects.append(ClothDefect.assignType(type: defect))
        }
        
        var cloth = ClothEntity(
            id: id,
            owner: ownerID,
            photo: nil,
            defects: clothDefects,
            color: ClothColor.assignType(type: color),
            category: ClothType.assignType(type: category),
            description: description,
            price: price,
            status: ClothStatus.assignStatus(status: status)
        )
        
        guard
            let url = photo.fileURL,
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)
        else {
            return cloth
        }
        
        let cleanImage = ImageProcessingService().removeBackground(input: image)
        cloth.photo = cleanImage
        
        return cloth
    }
}
