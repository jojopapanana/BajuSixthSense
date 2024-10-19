//
//  Router.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 18/10/24.
//

import Foundation
import SwiftUI

enum Router: Hashable {
    case Upload(state: ClothDataState, cloth: ClothEntity)
    case ProductDetail(bulk: CatalogItemEntity, isOwner: Bool)
    case Profile(items: [CatalogItemEntity]?)
    case ProfileItemList(status: ClothStatus)
    case EditProfile
    
    var id: Self { self }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Router, rhs: Router) -> Bool {
        switch (lhs, rhs) {
            case (.Upload, .Upload):
                return true
            case (.ProductDetail(let lhsItem, let lhsOwner), .ProductDetail(let rhsItem, let rhsOwner)):
                return lhsItem == rhsItem && lhsOwner == rhsOwner
            case (.Profile(let lhs), .Profile(let rhs)):
                return lhs == rhs
            case (.ProfileItemList(let lhs), .ProfileItemList(let rhs)):
                return lhs == rhs
            case (.EditProfile, .EditProfile):
                return true
            default:
                return false
        }
    }
}

extension Router: View {
    var body: some View {
        switch self {
            case .Upload(let state, let entity):
                UploadClothView(viewState: state, uploadVM: UploadClothViewModel(defaultCloth: entity))
            case .ProductDetail(let bulk, let isowner):
                CatalogDetailView(bulk: bulk, isOwner: isowner)
            case .Profile(let items):
                ProfileView(catalogItems: items)
            case .ProfileItemList(let status):
                ProfileAllCatalogueView(statusText: status)
            case .EditProfile:
                EditProfileView()
        }
    }
}
