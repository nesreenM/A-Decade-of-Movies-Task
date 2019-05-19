//
//  Extensions.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func startShimmering() {
        self.backgroundColor = UIColor.init(red: 190/255, green: 190/255, blue: 190/255, alpha: 0.51)
        let light = UIColor.white.withAlphaComponent(0.7).cgColor
        let alpha = UIColor.black.cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, light, alpha]
        gradient.frame = CGRect(x: -self.bounds.size.width,
                                y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        
        gradient.locations = [0.4, 0.5, 0.6]
        self.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.5
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering() {
        DispatchQueue.main.async {
            self.layer.mask = nil
            self.backgroundColor = .clear
        }
    }
}

extension UIImageView {
    
    func setImage(url: String, placeHolderImageName: String) {
        
        if let image = PhotosManager.shared.cachedImage(for: url) {
            DispatchQueue.main.async {
                self.stopShimmering()
                self.image = image
                self.image?.af_inflate()
            }
            return
        }
        DispatchQueue.main.async {
            self.startShimmering()
        }
        PhotosManager.shared.retrieveImage(for: url) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.stopShimmering()
                    self.image = image
                }
                return
            }
            DispatchQueue.main.async {
                self.stopShimmering()
//                self.image = UIImage(named: placeHolderImageName)
            }
        }
    }
}

extension UInt64 {
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
}
