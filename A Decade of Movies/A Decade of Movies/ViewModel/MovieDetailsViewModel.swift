//
//  MovieDetailsViewModel.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    
    var movie: Movie
    var flickrPhotos: FlickrPhotos!
    
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
    
    func getFlickerImages(movieName: String) {
        let queryParameter = ["text" : movieName]
        NetworkRequests.shared.get(baseUrl: "api.flickr.com", urlString: "/services/rest/?method=flickr.photos.search&api_key=ec2825280176da1fa263c72494302074&format=json&nojsoncallback=1", headers: [:], urlParameter: nil, queryParameters: queryParameter) {(_, response: Result <FlickrPhotos, ErrorObject>) in
            switch response {
            case .success(let result):
                self.flickrPhotos = result
                return
            case .failure(let error):
                print("Error in fetching content", error.self)
                return
            }
        }
    }
}
