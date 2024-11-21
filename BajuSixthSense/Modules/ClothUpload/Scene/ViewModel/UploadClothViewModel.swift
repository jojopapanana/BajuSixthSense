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
    static let shared = UploadClothViewModel()
    private let uploadUsecase = DefaultUploadClothUseCase()
    private let editUseCase = DefaultWardrobeUseCase()
    private let imageService = ImageProcessingService()
    
    @Published var unprocessedImages = [UIImage?]()
    @Published var clothesUpload = [ClothEntity]()
    @Published var completeProcessing = false
    @Published var showImagePicker: Bool = false
    
    var userID: String?
    
    init() {
        guard let user = LocalUserDefaultRepository().fetch() else {
            return
        }
        
        self.userID = user.userID ?? ""
    }
    
    func uploadCloth() throws {
        Task {
            do {
                for cloth in clothesUpload {
                    try await uploadUsecase.saveNewCloth(cloth: cloth)
                }
                WardrobeViewModel.shared.updateWardrobe()
            } catch {
                throw ActionFailure.FailedAction
            }
        }
    }
    
    func updateCloth(cloth: ClothEntity) throws {
        Task {
            do {
                try await uploadUsecase.updateCloth(cloth: cloth)
            } catch {
                throw error
            }
        }
    }
    
    func fetchClothType() -> [ClothType] {
        return ClothType.allCases.dropLast()
    }
    
    func fetchClothColor() -> [ClothColor] {
        return ClothColor.allCases.dropLast()
    }
    
    func fetchClothDefects() -> [ClothDefect] {
        return ClothDefect.allCases.dropLast()
    }
    
    func fetchPhoto() -> [UIImage?] {
        return unprocessedImages
    }
    
    func addClothImage(image: UIImage?) {
        unprocessedImages.append(image)
    }
    
    func removeImage(index: Int) {
        unprocessedImages.remove(at: index)
    }
    
    func removeFromUpload(cloth: ClothEntity) {
        guard let idx = clothesUpload.firstIndex(of: cloth) else { return }
        print(idx)
        clothesUpload.remove(at: idx)
    }
    
    func processClothData(_ images: [UIImage?]) {
        self.clothesUpload.removeAll()
        completeProcessing = false
        
        print("Flag")
        
        func processImage(at index: Int, images: [UIImage?]) {
            guard index < images.count, let image = images[index] else {
                completeProcessing = true
                print("finish")
                return
            }
            
            print("Ping \(index)")
            
            let dispatchGroup = DispatchGroup()
            var localTypeResult = ""
            var localColorResult = ""
            
            dispatchGroup.enter()
            let removeBackground = imageService.removeBackground(input: image)
            dispatchGroup.leave()
            
            dispatchGroup.enter()
            let cropImage = imageService.saliencyCropping(input: removeBackground)
            dispatchGroup.leave()
            
            dispatchGroup.enter()
            classifyClothingType(cropImage) { result in
                localTypeResult = result
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            classifyClothingColor(cropImage) { result in
                localColorResult = result
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                let cloth = ClothEntity(
                    id: nil,
                    owner: self.userID ?? "",
                    photo: cropImage,
                    defects: [ClothDefect](),
                    color: ClothColor.assignType(type: localColorResult),
                    category: ClothType.assignType(type: localTypeResult),
                    description: "",
                    price: 0,
                    status: .Initial
                )
                
                print("Add Data")
                self.clothesUpload.append(cloth)
                processImage(at: index + 1, images: images)
            }
        }
        
        processImage(at: 0, images: images)
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
}
