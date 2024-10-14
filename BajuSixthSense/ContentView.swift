//
//  ContentView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 07/10/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        UploadClothView()
            .onAppear {
                Task {
                    let cloth = ClothEntity(
                        clothID: nil,
                        owner: "10FEF4E1-4B44-4F55-840B-ADA65F94D316",
                        photos: [UIImage(named:"BusinessHappyHandsUp")!, UIImage(named: "DefaultHappyHandsUp")!],
                        quantity: 2,
                        category: [ClothType.Pants],
                        additionalNotes: "Test",
                        lastUpdated: Date.now,
                        status: ClothStatus.Available
                    )
                    
                    let usecase = DefaultUploadClothUseCase()
                    let response = await usecase.saveNewCloth(cloth: cloth)
                    
                    print(response)
                }
            }
    }
}

#Preview {
    ContentView()
}
