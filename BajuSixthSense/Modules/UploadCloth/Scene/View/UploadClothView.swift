// 
//  UploadClothViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct UploadClothView: View {
    @StateObject private var vm = UploadClothViewModel(usecase: DefaultUploadClothUseCase(repository: DefaultUploadClothRepository()))
    
    var body: some View {
        VStack {
            Button("Upload Cloth") {
                vm.upload(images: ["Baju1.jpg", "Baju2.jpg"], clothesType: ["T-shirt", "Shirt"], clothesQty: 10, additionalNotes: "bajunya bagus semua")
            }
            
            if (vm.uploadResult != nil) == true {
                Text("Berhasil upload")
            } else {
                Text("Gagal huhuuu")
            }
        }
    }
}

#Preview {
    UploadClothView()
}
