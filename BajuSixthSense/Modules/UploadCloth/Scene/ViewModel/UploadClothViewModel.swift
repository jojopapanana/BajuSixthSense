// 
//  UploadClothViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

internal final class UploadClothViewModel {

}

extension UploadClothViewModel {
    enum UploadClothResultData {
        case initial
        case success(UploadClothModel)
        case failure(Error)
    }
}
