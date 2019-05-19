//
//  Movie+CoreDataClass.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject, Decodable {
  
    enum CodingKeys: String, CodingKey {
        case title, year, rating, cast, genre
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // Create NSEntityDescription with NSManagedObjectContext
        guard let managedObjectContext = CoreDataStack.sharedInstance.persistentContainer.viewContext as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
                fatalError("Failed to decode Movie!")
        }
        self.init(entity: entity, insertInto: nil)
        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        year = try values.decode(Int16.self, forKey: .year)
        rating = try values.decode(Double.self, forKey: .rating)
        genre = try values.decode([String].self, forKey: .genre)
        cast = try values.decode([String].self, forKey: .cast)
    }
}

extension Movie: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(year, forKey: .year)
        try container.encode(rating, forKey: .rating)
        try container.encode(genre, forKey: .genre)
        try container.encode(cast, forKey: .cast)
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
