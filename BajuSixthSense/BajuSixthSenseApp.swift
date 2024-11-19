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
    var vm = RootAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    Task {
                        if !(url.path().isEmpty) || !(url.path() == "/") {
                            let router = await vm.handleURLPath(from: url)
                            navigationRouter.push(to: router)
                        }
                    }
                }
        }
        .environmentObject(navigationRouter)
    }
}
