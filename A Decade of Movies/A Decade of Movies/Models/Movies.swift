//
//  Movies.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation

struct Movies: Codable {
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies
    }
}
