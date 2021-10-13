//
//  PHPicker.swift
//  BigDaddyUploader
//
//  Created by 杨焕钦 on 2021/10/10.
//

import PhotosUI
import SwiftUI


struct PhotoPicker: UIViewControllerRepresentable {
    let configuration: PHPickerConfiguration
    @Binding var pickerResult: [UIImage]
    @Binding var isPresented: Bool
    @Binding var resultName :[String]
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // PHPickerViewControllerDelegate => Coordinator
    class Coordinator: PHPickerViewControllerDelegate {
        
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self)  {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { (newImage, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.parent.pickerResult.append(newImage as! UIImage)
                        }
                    }
                    self.parent.resultName.append((image.itemProvider.suggestedName!))
                } else {
                    print("Loaded Assest is not a Image")
                }
                
           }
             //dissmiss the picker
            parent.isPresented = false
        }
    }
}
