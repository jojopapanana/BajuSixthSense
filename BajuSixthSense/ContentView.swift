//
//  ContentView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 07/10/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @State var isRegistered = false
    
    var profileUsecase = DefaultProfileUseCase()
    
    var body: some View {
        NavigationStack(path: $navigationRouter.routePath) {
            if isRegistered {
//                CatalogView()
//                    .navigationDestination(for: Router.self) { routerView in
//                        routerView
//                    }
            } else {
                OnboardingView(isOnBoarded: $isRegistered)
            }
        }
        .onAppear {
            isRegistered = profileUsecase.checkUserRegistration()
        }
    }
}

#Preview {
    ContentView()
}
