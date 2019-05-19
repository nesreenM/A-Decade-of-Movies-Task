//
//  MovieDetailsViewModel.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation

struct MovieDetailsViewModel {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func listingCast() -> String {
        var castList = ""
        for cast in movie.cast ?? [] {
            castList = "\u{2022} \(cast) \n"
        }
        return castList
    }
    
    func listingGenre() -> String {
        var genreList = ""
        for genre in movie.genres ?? [] {
            genreList = "\u{2022} \(genre) \n"
        }
        return genreList
    }
}
