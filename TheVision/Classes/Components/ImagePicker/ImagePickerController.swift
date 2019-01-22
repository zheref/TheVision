//
//  ImagePickerController.swift
//  TheVision
//
//  Created by Sergio Lozano García on 8/1/18.
//

import UIKit
import PhotosUI

public typealias VSImageGrabber = (UIImage?) -> Void

public class VSImagePickerController : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker: UIImagePickerController?
    var grabber: VSImageGrabber?
    var parentVC: UIViewController?
    
    public func grabOneFromGallery(through grabber: @escaping VSImageGrabber, from vc: UIViewController) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined: PHPhotoLibrary.requestAuthorization({ (newStatus) in
            print("status is \(newStatus)")
                
            if newStatus == PHAuthorizationStatus.authorized {
                /* do stuff here */ print("success")
            }
        })
            
        case .restricted:
            // print("User do not have access to photo album.")
            return
        case .denied:
            // print("User has denied the permission.")
            return
        }
        
        if picker == nil {
            picker = UIImagePickerController()
            picker?.sourceType = .photoLibrary
            picker?.delegate = self
            
        }
        
        self.grabber = grabber
        self.parentVC = vc
        
        guard let picker = picker else {
            return
        }
        
        parentVC?.present(picker, animated: true, completion: nil)
    }
    
    @objc public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parentVC?.dismiss(animated: true, completion: nil)
        grabber?(nil)
    }
    
    @objc public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage?
        
        if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
            
            guard let newImage = newImage else {
                return
            }
            
            print(newImage.size)
            grabber?(newImage)
            parentVC?.dismiss(animated: true, completion: nil)
        } else {
            return
        }
    }
    
}
