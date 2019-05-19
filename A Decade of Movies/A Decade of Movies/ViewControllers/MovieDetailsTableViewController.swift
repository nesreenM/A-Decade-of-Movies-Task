//
//  MovieDetailsTableViewController.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var cast: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var picturesCollectionView: UICollectionView!
    
    var movieDetailsViewModel: MovieDetailsViewModel!
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0,
                                             left: 15.0,
                                             bottom: 10.0,
                                             right: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        setupCollectionView()
        bindData()
        fetchPhotos()
    }
    
    func bindData() {
        movieYear.text = movieDetailsViewModel.movie.year.description
        movieTitle.text = movieDetailsViewModel.movie.title
        cast.text = movieDetailsViewModel.listingCast()
        genre.text = movieDetailsViewModel.listingGenre()
    }
    
    func setupCollectionView() {
        picturesCollectionView.dataSource = self
        picturesCollectionView.delegate = self
    }
    
    func fetchPhotos() {
        movieDetailsViewModel.getFlickerImages(movieName: movieDetailsViewModel.movie.title ?? "") { (isSuccess) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.picturesCollectionView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            let photosCount = movieDetailsViewModel.flickrPhotos?.photos?.photo?.count ?? 0
            return CGFloat(100 * photosCount)
        }
        return UITableView.automaticDimension
    }
    
}

extension MovieDetailsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetailsViewModel.flickrPhotos?.photos?.photo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePictureCell", for: indexPath) as! MoviePictureCollectionViewCell
        if let photo = movieDetailsViewModel.flickrPhotos?.photos?.photo?[indexPath.row] {
            cell.moviePictureCellViewModel = MoviePictureCellViewModel(photo: photo)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 100)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
