//
//  PhotosManager.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation

import AlamofireImage

class PhotosManager{
    static let shared = PhotosManager()
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    func retrieveImage(for url: String, completion: @escaping (UIImage?) -> Void){
        
        downloadImage(url: url){
            (imageData , error) in
            guard let imageData = imageData else {
                completion(nil)
                return
            }
            if let image = UIImage(data: imageData){
                completion(image)
                self.cache(image, for: url)
            }
        }
    }
    
    func downloadImage(url: String, completion: @escaping (_ imageData: Data? , _ error: String?) -> ()){
        if let url = URL(string: url){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    completion(data,nil)
                }else{
                    completion(nil,"Error occurred")
                }
            }
            task.resume()
        }else{
            completion(nil,"Error occurred")
        }
    }
    //MARK: - Image Caching
    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
}

