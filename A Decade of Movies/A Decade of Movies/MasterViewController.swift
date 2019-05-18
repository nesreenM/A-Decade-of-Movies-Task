//
//  MasterViewController.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    var isFiltering = false
   var moviesTableViewModel = MoviesTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
    }

    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return moviesTableViewModel.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = moviesTableViewModel.fetchedResultsController.sections?[section]
        return sectionInfo?.numberOfObjects ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = moviesTableViewModel.fetchedResultsController.object(at: indexPath)
        return cell
    }
}

extension MasterViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
//        fetchMovies()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchtext = searchController.searchBar.text, searchtext.count > 0 {
            isFiltering = true
//            searchMovie(withName: searchtext)
        }
    }
}
