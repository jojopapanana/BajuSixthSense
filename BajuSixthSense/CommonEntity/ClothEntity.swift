//
//  ClothEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit
import SwiftUI

struct ClothEntity: Identifiable, Hashable {
    var id: String?
    var owner: String
    var photos: [UIImage?]
    var quantity: Int?
    var category: [ClothType]
    var additionalNotes: String
    var lastUpdated: Date
    var status: ClothStatus
    
    init() {
        self.id = nil
        self.owner = ""
        self.photos = [UIImage?]()
        self.quantity = nil
        self.category = [ClothType]()
        self.additionalNotes = ""
        self.lastUpdated = Date.now
        self.status = ClothStatus.Draft
    }
    
    init(clothID: String?, owner: String, photos: [UIImage?], quantity: Int, category: [ClothType], additionalNotes: String, lastUpdated: Date, status: ClothStatus) {
        self.id = clothID
        self.owner = owner
        self.photos = photos
        self.quantity = quantity
        self.category = category
        self.additionalNotes = additionalNotes
        self.lastUpdated = lastUpdated
        self.status = status
    }
}

extension ClothEntity {
    func mapToDTO() -> ClothDTO {
        var assets = [CKAsset]()
        
        self.photos.forEach { photo in
            guard
                let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("asset#\(UUID.init().uuidString)"),
                let data = photo?.jpegData(compressionQuality: 1.0)
            else { return }
            
            do {
                try data.write(to: url)
                let asset = CKAsset(fileURL: url)
                assets.append(asset)
            } catch {
                print("Error writing asset: \(error)")
            }
        }
        
        var categories = [String]()
        
        self.category.forEach { category in
            categories.append(category.rawValue)
        }
        
        return ClothDTO(
            ownerID: self.owner,
            photos: assets,
            quantity: self.quantity ?? 0,
            categories: categories,
            additionalNotes: self.additionalNotes,
            status: self.status.rawValue
        )
    }
}
