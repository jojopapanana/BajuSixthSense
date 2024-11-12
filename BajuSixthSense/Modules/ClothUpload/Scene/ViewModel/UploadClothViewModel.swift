// 
//  UploadClothViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import SwiftUI
import CoreML
import Vision

class UploadClothViewModel: ObservableObject {
    private let uploadUsecase = DefaultUploadClothUseCase()
    private let editUseCase = DefaultWardrobeUseCase()
    
    @Published var classificationResult: [String] = []
    @Published var colorClassificationResult: [String] = []
    @Published var defects: [[String]] = [[""]]
    @Published var description: [String] = [""]
    @Published var price: [Int] = [0]
    @Published var clothes: [ClothParameter] = []
    @Published var isClassificationComplete = false
    @Published var showImagePicker: Bool = false
    @Published var defaultCloth: ClothEntity
    @Published var disablePrimary = true
    @Published var disableSecondary = true
    
    init(defaultCloth: ClothEntity = ClothEntity()) {
        self.defaultCloth = defaultCloth
    }
    
    func uploadCloth() throws {
        Task {
            checkClothStatus()
            
            let result = await uploadUsecase.saveNewCloth(cloth: defaultCloth)
            
            if result == ActionFailure.NilStringError.rawValue {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func checkClothStatus() {
        DispatchQueue.main.async {
            if !self.disablePrimary {
                self.defaultCloth.status = .Posted
            } else {
                self.defaultCloth.status = .Draft
            }
        }
    }
    
    func updateCloth() throws {
        Task {
            let result = await editUseCase.editCloth(cloth: defaultCloth)
            
            if !result {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func deleteCloth() throws {
        Task {
            guard let clothID = defaultCloth.id else {
                throw ActionFailure.NilStringError
            }
            
            let result = await editUseCase.deleteCloth(clothID: clothID)
            
            if !result {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func fetchPhoto() -> [UIImage?] {
        return defaultCloth.photos
    }
    
    func addClothImage(image: UIImage?) {
        defaultCloth.photos.append(image)
        checkFields()
        print(defaultCloth.photos.count)
    }
    
    func removeImage(index: Int) {
        defaultCloth.photos.remove(at: index)
        checkFields()
        print(defaultCloth.photos.count)
    }
    
    func checkCategory(type: ClothType) -> Bool {
        if defaultCloth.category.contains(type) {
            return true
        } else {
            return false
        }
    }
    
    func addCategoryType(type: ClothType) {
        defaultCloth.category.append(type)
        checkFields()
    }
    
    func removeCategoryType(type: ClothType) {
        guard let index = defaultCloth.category.firstIndex(of: type) else {
            return
        }
        
        defaultCloth.category.remove(at: index)
        checkFields()
    }
    
    func fetchClothType() -> [ClothType] {
        return ClothType.allCases.dropLast()
    }
    
    func allFieldFilled() {
        let photoStatus = defaultCloth.photos.isEmpty
        let quantityStatus = defaultCloth.quantity == nil || (defaultCloth.quantity ?? 0) == 0
        let typeStatus = defaultCloth.category.isEmpty
        
        disablePrimary = photoStatus || quantityStatus || typeStatus
    }
    
    func anyFieldFilled() {
        let photoStatus = defaultCloth.photos.isEmpty
        let quantityStatus = defaultCloth.quantity == nil || (defaultCloth.quantity ?? 0) == 0
        let typeStatus = defaultCloth.category.isEmpty
        
        disableSecondary = photoStatus && quantityStatus && typeStatus
    }

    func checkFields() {
        allFieldFilled()
        anyFieldFilled()
    }
    
    func classifyCloth(_ images: [UIImage?]){
        self.classificationResult.removeAll()
        self.colorClassificationResult.removeAll()
        isClassificationComplete = false
        
        func classifyImage(at index: Int) {
            guard index < images.count, let image = images[index] else {
                isClassificationComplete = true
                return
            }
            
            let dispatchGroup = DispatchGroup()
            var localTypeResult = ""
            var localColorResult = ""
            
            dispatchGroup.enter()
            classifyClothingType(image) { result in
                localTypeResult = result
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            classifyClothingColor(image) { result in
                localColorResult = result
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                self.colorClassificationResult.append(localColorResult)
                self.classificationResult.append(localTypeResult)
                self.defects.append([""])
                self.description.append("")
                self.price.append(0)
                classifyImage(at: index + 1) // Proceed to the next image
            }
        }
        
        classifyImage(at: 0)
    }

    func classifyClothingType(_ image: UIImage, completion: @escaping (String) -> Void) {
        guard let model = try? VNCoreMLModel(for: ClothesTypeClassifier_3().model) else {
            completion("Failed to load model")
            return
        }
        
            guard let cgImage = image.cgImage else {
                completion("Failed to convert image")
                return
            }

            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let classifications = request.results as? [VNClassificationObservation], let topResult = classifications.first {
                    DispatchQueue.main.async {
                        completion(topResult.identifier)
                        print("result: \(self.classificationResult)")
                    }
                } else {
                    DispatchQueue.main.async {
                        completion("No classifications found")
                    }
                }
                
            }

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    DispatchQueue.main.async {
                        completion("Error performing classification")
                    }
                    
                }
            }
    }
    
    func classifyClothingColor(_ image: UIImage, completion: @escaping (String) -> Void){
        guard let model = try? VNCoreMLModel(for: ClothesColorDetection().model) else {
            completion("Color - Failed to load model")
            return
        }
        
            guard let cgImage = image.cgImage else {
                completion("Color - Failed to convert image")
                return
            }

            let request = VNCoreMLRequest(model: model) { (request, error) in
                if let classifications = request.results as? [VNClassificationObservation], let topResult = classifications.first {
                    DispatchQueue.main.async {
                        completion(topResult.identifier)
                        print("color: \(self.colorClassificationResult)")
                    }
                } else {
                    DispatchQueue.main.async {
                        completion("Color - No classifications found")
                    }
                }
            }

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    DispatchQueue.main.async {
                        completion("Color - Error performing classification")
                    }
                }
            }
    }
    
    func insertClothestoParameter(image: UIImage, type: String, color: String, defects: [String]?, description: String?, price: Int?){
        let cloth = ClothParameter(id: UUID().uuidString, clothImage: image, clothType: type, clothColor: color, clothDefects: defects, clothDescription: description, clothPrice: price)
        
        self.clothes.append(cloth)
    }
}
