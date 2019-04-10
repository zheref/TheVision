//
// Created by Sergio Daniel on 2019-04-08.
//

import UIKit
import PowerStone

let imageCache = NSCache<NSString, UIImage>()

public extension UIImageView {
    func loadImage(usingUrlString urlString: String, completion: PSHandler? = nil) {
        guard let url = URL(string: urlString) else {
            let error = PSError(code: "F-4", message: "Unable to parse url: \(urlString)")
            print(error.readableDeveloperMessage)
            return
        }

        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            image = imageFromCache
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if let error = error {
                if let response = response as? HTTPURLResponse {
                    let pserror = PSError(code: "HTTP-\(response.statusCode)", message: error.localizedDescription, error: error)
                    print(pserror.readableDeveloperMessage)
                } else {
                    let pserror = PSError(code: "HTTP-?", message: error.localizedDescription, error: error)
                    print(pserror.readableDeveloperMessage)
                }
            }

            guard let data = data else {
                let pserror = PSError(code: "HTTP", message: "No error but no data on HTTP response either")
                print(pserror.readableDeveloperMessage)
                return
            }

            DispatchQueue.main.async(execute: {
                guard let imageToCache = UIImage(data: data) else {
                    return
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
                self?.image = UIImage(data: data)
            })
        })
        
        task.resume()
    }
}
