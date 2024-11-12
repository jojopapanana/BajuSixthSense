//
//  BajuSixthSenseApp.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 07/10/24.
//

import SwiftUI

@main
struct BajuSixthSenseApp: App {
    @StateObject var navigationRouter = NavigationRouter()
    var urlManager = URLSharingManager()
    var catalogUseCase = DefaultCatalogUseCase()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    Task {
                        let id = urlManager.retreiveClothID(from: url)
                        
                        var item: CatalogItemEntity
                        
                        if !id.isEmpty {
                            do {
                                item = try await catalogUseCase.fetchSharedCatalogItem(clothID: id)
                                navigationRouter.push(to: .ProductDetail(bulk: item, isOwner: CatalogViewModel.checkIsOwner(ownerId: item.owner.id)))
                            } catch {
                                print("Failed opening detail from link: \(error.localizedDescription)")
                            }
                        }
                    }
                }
        }
        .environmentObject(navigationRouter)
    }
}
