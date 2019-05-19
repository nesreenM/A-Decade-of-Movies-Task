//
//  FlickrPhotos.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation

struct FlickrPhotos: Codable {
    let photos: Photos?
    let stat: String?
}

struct Photos: Codable {
    let page, pages, perpage: Int?
    let total: String?
    let photo: [Photo]?
}

struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
}
