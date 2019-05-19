//
//  MoviePictureCollectionViewCell.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import UIKit

class MoviePictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePicture: UIImageView!
    
    var moviePictureCellViewModel: MoviePictureCellViewModel! {
        didSet {
            bindData()
        }
    }
    
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.moviePicture.image = nil
        }
    }
    
    func bindData() {
        let farm = moviePictureCellViewModel.photo.farm ?? 0
        let server = moviePictureCellViewModel.photo.server ?? ""
        let id = moviePictureCellViewModel.photo.id ?? ""
        let secret = moviePictureCellViewModel.photo.secret ?? ""
//        let url = "https://farm​\(farm)​.static.flickr.com/​\(server)​/​\(id)_​\(secret)​.jpg"
        let url = "https://farm66.static.flickr.com/65535/32885403967_be14b95a9c.jpg"
        moviePicture.setImage(url: url)
    }
}
