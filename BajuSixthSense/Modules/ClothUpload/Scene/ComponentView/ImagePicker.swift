//
//  ImagePicker.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 03/10/24.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var chosenImage: UIImage?
    @ObservedObject var uploadVM: UploadClothViewModel
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let controlHeight: CGFloat = 150
        let previewHeight = screenHeight - controlHeight
            
        let previewOverlay = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: previewHeight))
        previewOverlay.isUserInteractionEnabled = false
        previewOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        let squareSideLength = screenWidth
        let squareFrame = CGRect(
            x: 0,
            y: ((previewHeight - squareSideLength) / 2) + 20,
            width: squareSideLength,
            height: squareSideLength
        )

        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: previewOverlay.bounds)
        let squarePath = UIBezierPath(rect: squareFrame)
        path.append(squarePath)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        previewOverlay.layer.mask = maskLayer

        imagePicker.cameraOverlayView = previewOverlay
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//                parent.chosenImage = image
//                parent.uploadVM.addClothImage(image: image)
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
