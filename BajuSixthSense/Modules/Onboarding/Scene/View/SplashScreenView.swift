//
//  SplashScreenView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 14/10/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color("SystemPrimary")
                .ignoresSafeArea()
            Image("SplashScreenAsset")
                .padding(.top, 250)
        }
    }
}

#Preview {
    SplashScreenView()
}
