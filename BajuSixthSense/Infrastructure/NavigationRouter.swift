//
//  NavigationRouter.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 18/10/24.
//

import Foundation

class NavigationRouter: ObservableObject {
    @Published var routePath = [Router]()
    
    func push(to route: Router) {
        if routePath.contains(route) {
            return
        }else {
            routePath.append(route)
        }
    }
    
    func goBack() {
        routePath.removeLast()
    }
    
    func backToDiscovery() {
        routePath.removeAll()
    }
    
    func redirect(to path: [Router]) {
        routePath = path
    }
}
