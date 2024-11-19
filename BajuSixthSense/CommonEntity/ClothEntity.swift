//
//  ClothEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit
import SwiftUI

/*
 - id
 - ownerId
 - photo: CKAsset
 - clothName: String
 - deffect: [String]
 - description
 - price
 - status
 */

struct ClothEntity: Identifiable, Hashable, Equatable {
    var id: String?
    var owner: String
    var photo: UIImage?
    var defects: [ClothDefect]
    var color: ClothColor
    var category: ClothType
    var description: String
    var price: Int
    var status: ClothStatus
    
    init() {
        self.id = nil
        self.owner = ""
        self.photo = nil
        self.defects = [ClothDefect]()
        self.color = .Error
        self.category = .Error
        self.description = ""
        self.price = 0
        self.status = .Initial
    }
    
    init(
        id: String?,
        owner: String,
        photo: UIImage?,
        defects: [ClothDefect],
        color: ClothColor,
        category: ClothType,
        description: String,
        price: Int,
        status: ClothStatus
    ){
        self.id = id
        self.owner = owner
        self.photo = photo
        self.defects = defects
        self.color = color
        self.category = category
        self.description = description
        self.price = price
        self.status = status
    }
}

extension ClothEntity {
    func mapToDTO() -> ClothDTO {
        var clothDefects = [String]()
        
        self.defects.forEach { defect in
            clothDefects.append(defect.rawValue)
        }
        
        var cloth = ClothDTO(
            ownerID: self.owner,
            photo: nil,
            defects: clothDefects,
            color: self.color.rawValue,
            category: self.category.rawValue,
            description: self.description,
            price: self.price,
            status: self.status.rawValue
        )
        
        guard
            let url = FileManager.default.urls(
                for: .cachesDirectory,
                in: .userDomainMask
            )
                .first?
                .appendingPathComponent(
                    "asset#\(UUID.init().uuidString)"
                ),
            let data = photo?.jpegData(compressionQuality: 1.0)
        else {
            return cloth
        }
        
        do {
            try data.write(to: url)
            cloth.photo = CKAsset(fileURL: url)
        } catch {
            print("Error writing asset: \(error)")
        }
        
        return cloth
    }
    
    func generateClothName() -> String {
        return self.category.getName + " " + self.color.getName
    }
    
    func generateDefectsString() -> String {
        var defectsString: String = ""
        
        for index in 0..<self.defects.count {
            let defect = self.defects[index].rawValue
            defectsString += "\(defect)"
            
            if index < self.defects.count - 1 {
                defectsString += " • "
            }
            
            if index == 1 && self.defects.count > 2 {
                defectsString += "+\(self.defects.count - 2)"
                break
            }
        }
        
        return defectsString
    }
    
    func generateAllDefects() -> String {
        var defectsString: String = ""
        
        for index in 0..<self.defects.count {
            let defect = self.defects[index].rawValue
            defectsString += "\(defect)"
            
            if index < self.defects.count - 1 {
                defectsString += " • "
            }
        }
        
        return defectsString
    }
    
    func generatePriceString() -> String {
        if self.price == 0 {
            return "Gratis"
        } else {
            return "Rp \(self.price)"
        }
    }
}
