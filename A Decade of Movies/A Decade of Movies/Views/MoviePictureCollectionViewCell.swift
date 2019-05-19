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
    
    override func awakeFromNib() {
        bindData()
    }
    
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.moviePicture.image = nil
        }
    }
    
    func bindData() {
        moviePicture.setImage(url: "")
    }
}
