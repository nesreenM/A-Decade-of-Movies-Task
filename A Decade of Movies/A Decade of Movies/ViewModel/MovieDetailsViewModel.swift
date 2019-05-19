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
    
    func getFlickerImages(movieName: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        var queryParameter = ["text" : movieName]
       queryParameter["format"] = "json"
        queryParameter["api_key"] = "ec2825280176da1fa263c72494302074"
        queryParameter["method"] = "flickr.photos.search"
        queryParameter["nojsoncallback"] = "1"

        NetworkRequests.shared.get(baseUrl: "api.flickr.com", urlString: "/services/rest/", headers: [:], urlParameter: nil, queryParameters: queryParameter) {(_, response: Result <FlickrPhotos, ErrorObject>) in
            switch response {
            case .success(let result):
                self.flickrPhotos = result
                completion(true)
                return
            case .failure(let error):
                print("Error in fetching content", error.self)
                completion(false)
                return
            }
        }
    }
}

class MoviePictureCellViewModel {
    var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
}
