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
        if let farm = moviePictureCellViewModel.photo.farm,
            let server = moviePictureCellViewModel.photo.server,
            let id = moviePictureCellViewModel.photo.id,
            let secret = moviePictureCellViewModel.photo.secret {
            let url = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
            moviePicture.setImage(url: url)
        }
    }
}
