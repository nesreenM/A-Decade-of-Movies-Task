//
//  A_Decade_of_MoviesTests.swift
//  A Decade of MoviesTests
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import XCTest
@testable import A_Decade_of_Movies

class A_Decade_of_MoviesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
