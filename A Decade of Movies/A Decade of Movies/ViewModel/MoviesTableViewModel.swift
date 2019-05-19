//
//  MoviesTableViewModel.swift
//  A Decade of Movies
//
//  Created by Nesreen Mamdouh on 5/19/19.
//  Copyright © 2019 swvl. All rights reserved.
//

import Foundation
import CoreData

struct MoviesTableViewModel {
 
    lazy var fetchedResultsController: NSFetchedResultsController<Movie> = {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "year", ascending: false), NSSortDescriptor(key: "title", ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: "year", cacheName: nil)
        return fetchedResultsController
    }()
    
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
            movie.setValue(savedMovie?.cast, forKey: "cast")
            movie.setValue(savedMovie?.genres, forKey: "genres")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    mutating func entityIsEmpty() -> Bool {
        if fetchedResultsController.fetchedObjects?.count == 0 {
            return true
        }
        return false
    }
    
    mutating func searchMovie(withName: String, completion: (_ isSuccess: Bool) -> Void) {
        fetchedResultsController.fetchRequest.predicate = NSPredicate(format:  "title MATCHES[cd] '(\(withName)).*'")
        fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "year", ascending: false), NSSortDescriptor(key: "rating", ascending: false)]
        do {
            try fetchedResultsController.performFetch()
            completion(true)
        } catch let error as NSError {
            print("Unresolved error \(error)")
            completion(false)
            abort()
        }
    }
    
    mutating func fetchMovies(completion: (_ isSuccess: Bool) -> Void){
        fetchedResultsController.fetchRequest.predicate = nil
        fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "year", ascending: false), NSSortDescriptor(key: "title", ascending: true)]
        do {
            try fetchedResultsController.performFetch()
            completion(true)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(false)
            abort()
        }
    }
}
