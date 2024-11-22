//
//  Router.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 18/10/24.
//

import Foundation
import SwiftUI

enum Router: Hashable {
    case Upload
    case UploadDetails
    case UploadReview
    case ProductDetail(clothItem: ClothEntity)
    case Profile(userID: String?)
    case EditClothItem(clothIdx: Int, cloth: ClothEntity)
    case EditProfile
    case ClothCart
    case FillData
    
    var id: Self { self }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Router, rhs: Router) -> Bool {
        switch (lhs, rhs) {
            case (.Upload, .Upload):
                return true
            case (.UploadDetails, .UploadDetails):
                return true
            case (.UploadReview, .UploadReview):
                return true
            case (.ProductDetail(let lhsItem), .ProductDetail(let rhsItem)):
                return lhsItem == rhsItem
            case (.Profile(let lhs), .Profile(let rhs)):
                return lhs == rhs
            case (.EditClothItem(let lhsIdx, let lhsItem), .EditClothItem(let rhsIdx, let rhsItem)):
                return lhsIdx == rhsIdx && lhsItem == rhsItem
            case (.EditProfile, .EditProfile):
                return true
            case (.ClothCart, .ClothCart):
                return true
            case (.FillData, .FillData):
                return true
            default:
                return false
        }
    }
}

extension Router: View {
    var body: some View {
        switch self {
        case .Upload:
            UploadPictureView()
        case .UploadDetails:
            UploadDetailsView()
        case .UploadReview:
            UploadReviewView()
        case .ProductDetail(let cloth):
            ProfileView(
                variantType: .penerima,
                presentSheet: true,
                clothData: cloth,
                profileVM: ProfileViewModel(id: cloth.owner),
                wardrobeVM: WardrobeViewModel(id: cloth.owner),
                cartVM: ClothCartViewModel.shared
            )
        case .Profile(let user):
            ProfileView(
                variantType: user == nil ? .pemberi : .penerima,
                presentSheet: false,
                clothData: ClothEntity(),
                profileVM: user == nil ? ProfileViewModel() : ProfileViewModel(id: user),
                wardrobeVM: user == nil ? WardrobeViewModel.shared : WardrobeViewModel(id: user ?? ""),
                cartVM: ClothCartViewModel.shared
            )
        case .EditClothItem (let clothIdx, let cloth):
            EditItemView(index: clothIdx, cloth: cloth, wardrobeVM: WardrobeViewModel.shared)
        case .EditProfile:
            EditProfileView()
        case .ClothCart:
            CartView()
        case .FillData:
            FillDataView()
        }
    }
}
