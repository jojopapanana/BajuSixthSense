//
//  AppViewModel.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 08/11/24.
//

import Foundation

class RootAppViewModel {
    let urlMng = URLSharingManager()
    
    func handleURLPath(from url: URL) async -> Router {
        let path = url.path()
        
        if path.contains("clothDetail") {
            let clothID = urlMng.retreiveID(from: url)
            let clothData = await CatalogViewModel.fetchClothData(clothId: clothID)
            return Router.ProductDetail(clothItem: clothData)
        } else {
            let userID = urlMng.retreiveID(from: url)
            return .Profile(userID: userID)
        }
    }
}
