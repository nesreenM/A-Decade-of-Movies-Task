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
   
    var movieDetailsViewModel: MovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        bindData()
    }
    
    func bindData() {
        movieYear.text = movieDetailsViewModel.movie.year.description
        movieTitle.text = movieDetailsViewModel.movie.title
        cast.text = movieDetailsViewModel.listingCast()
        genre.text = movieDetailsViewModel.listingGenre()
    }
    
}
