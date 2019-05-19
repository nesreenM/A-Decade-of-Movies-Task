//
//  MasterViewController.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import UIKit
import CoreData

class MoviesViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    var isFiltering = false
    var moviesTableViewModel = MoviesTableViewModel()
    typealias FetchingCompletion = (Bool) -> Void

    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        moviesTableViewModel.fetchMovies(completion: fetchMoviesCompletion())
        if moviesTableViewModel.entityIsEmpty() {
            let  movies = moviesTableViewModel.loadJsonFile(fileName: "movies")
            for movie in movies?.movies ?? [] {
                moviesTableViewModel.save(savedMovie: movie)
            }
            moviesTableViewModel.fetchMovies(completion: fetchMoviesCompletion())
        }
    }
    
    func fetchMoviesCompletion() -> FetchingCompletion {
        let completionHandler: FetchingCompletion = { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return completionHandler
    }

    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        searchController.searchBar.delegate = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
  
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return moviesTableViewModel.fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return moviesTableViewModel.fetchedResultsController.sections?[section].objects?.count ?? 0 <= 5 ? moviesTableViewModel.fetchedResultsController.sections?[section].objects?.count ?? 0 : 5
        }
        return moviesTableViewModel.fetchedResultsController.sections?[section].objects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = moviesTableViewModel.fetchedResultsController.object(at: indexPath)
        cell.movieName.text = movie.title
        cell.movieRating.text = movie.rating.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return moviesTableViewModel.fetchedResultsController.sections?[section].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesTableViewModel.fetchedResultsController.object(at: indexPath)
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie)
        let movieDetailsViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsTableViewController") as! MovieDetailsTableViewController
        movieDetailsViewController.movieDetailsViewModel = movieDetailsViewModel
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension MoviesViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        moviesTableViewModel.fetchMovies(completion: fetchMoviesCompletion())
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchtext = searchController.searchBar.text, searchtext.count > 0 {
            isFiltering = true
            moviesTableViewModel.searchMovie(withName: searchtext, completion: fetchMoviesCompletion())
        }
    }
}
