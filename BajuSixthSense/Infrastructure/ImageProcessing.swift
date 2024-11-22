//
//  ImageProcessing.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/11/24.
//

import Foundation
import SwiftUI
import Vision
import PhotosUI
import CoreImage.CIFilterBuiltins

class ImageProcessingService {
    
    func removeBackground(input image: UIImage?) -> UIImage {
        guard
            let inputImage = image?.optimizeScaling(),
            let cgImage = inputImage.cgImage
        else {
            print("Failed to load sample image.")
            return UIImage(systemName: "exclamationmark.triangle.fill")!
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let bgRequest = VNGenerateForegroundInstanceMaskRequest()
        
        do {
            try requestHandler.perform([bgRequest])
            
            guard let result = bgRequest.results?.first else {
                print("Failed to generate segmentation result")
                return UIImage(systemName: "exclamationmark.triangle.fill")!
            }
            
            let maskBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: requestHandler)
            let mask = CIImage(cvPixelBuffer: maskBuffer)
            
            guard let input = CIImage(image: inputImage) else {
                print("Error scaling mask")
                return UIImage(systemName: "exclamationmark.triangle.fill")!
            }
            
            let maskScaleX = input.extent.width / mask.extent.width
            let maskScaleY = input.extent.height / mask.extent.height
            let maskScaled = mask.transformed(by: CGAffineTransform(scaleX: maskScaleX, y: maskScaleY))
            
            let blendFilter = CIFilter.blendWithMask()
            blendFilter.inputImage = input
            blendFilter.maskImage = maskScaled
            blendFilter.backgroundImage = CIImage.empty()
            
            guard let output = blendFilter.outputImage else {
                print("Failed to apply mask filter")
                return UIImage(systemName: "exclamationmark.triangle.fill")!
            }
            
            let context = CIContext()
            if let cgImage = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
            }
        } catch {
            print("Failed process: \(error.localizedDescription)")
        }
        
        return UIImage(systemName: "exclamationmark.triangle.fill")!
    }
    
    func saliencyCropping(input image: UIImage) -> UIImage {
        guard let cgImage = image.cgImage else {
            print("Failed loading image")
            return UIImage(systemName: "exclamationmark.triangle.fill")!
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNGenerateObjectnessBasedSaliencyImageRequest()
        
        do {
            try requestHandler.perform([request])
            
            guard
                let result = request.results?.first as? VNSaliencyImageObservation
            else {
                print("Failed to retrieve saliency result")
                return UIImage(systemName: "exclamationmark.triangle.fill")!                }
            
            var salientRegion: CGRect? = nil
            
            guard let salientObjects = result.salientObjects else {
                print("Failed retrieving salient objects")
                return UIImage(systemName: "exclamationmark.triangle.fill")!
            }
            
            for salientObject in salientObjects {
                if salientRegion == nil {
                    salientRegion = CGRect(
                        x: salientObject.boundingBox.minX,
                        y: salientObject.boundingBox.minY,
                        width: salientObject.boundingBox.width,
                        height: salientObject.boundingBox.height
                    )
                }
                salientRegion =  salientRegion?.union(salientObject.boundingBox)
            }
            
            guard let unionObject = salientRegion else {
                print("Nill salient region.")
                return UIImage(systemName: "exclamationmark.triangle.fill")!
            }
            
            let salientRegionRect = CGRect(
                x: unionObject.minX,
                y: unionObject.minY,
                width: unionObject.width,
                height: unionObject.height
            )
            
            let salientRectBox = VNImageRectForNormalizedRect(
                salientRegionRect,
                Int((CIImage(image: image)?.extent.width ?? 1)),
                Int((CIImage(image: image)?.extent.height ?? 1))
            )
            
            guard
                let croppedImage = CIImage(image: image)?.cropped(to: salientRectBox)
            else { return UIImage(systemName: "exclamationmark.triangle.fill")! }
            
            guard
                let cgImage = CIContext().createCGImage(croppedImage, from: croppedImage.extent)
            else {
                print("Failed conversion")
                return UIImage(systemName: "exclamationmark.triangle.fill")!
            }
            
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
            
        } catch {
            print("Failed processing image saliency.")
        }
        
        return UIImage(systemName: "exclamationmark.triangle.fill")!
    }
    
}
