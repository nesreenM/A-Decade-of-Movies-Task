//
//  MoviesTableViewModel.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation
import CoreData

class MoviesTableViewModel {
    
    func loadJsonFile(fileName: String) -> Movies? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Movies.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func save(savedMovie: Movie?) {
        let managedContext =
            CoreDataStack.sharedInstance.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "Movie",
                                       in: managedContext)
        if let entity = entity {
            let movie = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
            movie.setValue(savedMovie?.title, forKeyPath: "title")
            movie.setValue(savedMovie?.rating, forKeyPath: "rating")
            movie.setValue(savedMovie?.year, forKeyPath: "year")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
