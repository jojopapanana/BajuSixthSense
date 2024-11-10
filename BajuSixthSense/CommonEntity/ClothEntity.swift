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
    var description: String
    var price: Int
    var status: ClothStatus
    
    init() {
        self.id = nil
        self.owner = ""
        self.photo = nil
        self.defects = [ClothDefect]()
        self.description = ""
        self.price = 0
        self.status = .Initial
    }
    
    init(
        id: String?,
        owner: String,
        photo: UIImage?,
        defects: [ClothDefect],
        description: String,
        price: Int,
        status: ClothStatus
    ){
        self.id = id
        self.owner = owner
        self.photo = photo
        self.defects = defects
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
}
