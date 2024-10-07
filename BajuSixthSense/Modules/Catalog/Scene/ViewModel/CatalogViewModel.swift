// 
//  CatalogViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

internal final class CatalogViewModel {

}

extension CatalogViewModel {
    enum CatalogResultData {
        case initial
        case success(CatalogModel)
        case failure(Error)
    }
}
