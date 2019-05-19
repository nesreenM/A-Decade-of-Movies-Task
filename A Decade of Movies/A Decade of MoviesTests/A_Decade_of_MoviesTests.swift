//
//  A_Decade_of_MoviesTests.swift
//  A Decade of MoviesTests
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import XCTest
import CoreData

@testable import A_Decade_of_Movies

class A_Decade_of_MoviesTests: XCTestCase {
    
    var mockMovieDetailsViewModel: MovieDetailsViewModel!
    
    override func setUp() {
        let managedContext =
            CoreDataStack.sharedInstance.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "Movie",
                                       in: managedContext)
        if let entity = entity {
            let movie = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
            movie.setValue("Mock Movie", forKeyPath: "title")
            movie.setValue(4.8, forKeyPath: "rating")
            movie.setValue(2018, forKeyPath: "year")
            movie.setValue(["Nesreen Mamdouh", "Tom Cruise"], forKey: "cast")
            movie.setValue(["Action", "Drama"], forKey: "genres")
            mockMovieDetailsViewModel = MovieDetailsViewModel(movie: movie as! Movie)
        }
    }

    override func tearDown() {
        mockMovieDetailsViewModel = nil
    }

    func testCastListing() {
        let listedCast = mockMovieDetailsViewModel.listingCast()
        var mockCast =  "\u{2022} Nesreen Mamdouh \n"
        mockCast += "\u{2022} Tom Cruise \n"
        XCTAssertEqual(listedCast, mockCast)
    }
    
    func testGenreListing() {
        let listedGenre = mockMovieDetailsViewModel.listingGenre()
        var mockGenre =  "\u{2022} Action \n"
        mockGenre += "\u{2022} Drama \n"
        XCTAssertEqual(listedGenre, mockGenre)
    }
    
    func testLoadingJsonFile() {
        let mockMoviesTableViewModel = MoviesTableViewModel()
        let mockMovie = mockMoviesTableViewModel.loadJsonFile(fileName: "movies")
        XCTAssertNotNil(mockMovie, "Json file doesn't exist")
    }

    func testSearchMovies(movieName: String) {
        var moviesTableViewModel = MoviesTableViewModel()
        moviesTableViewModel.searchMovie(withName: movieName, completion: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            testSearchMovies(movieName: "a")
        }
    }

}
