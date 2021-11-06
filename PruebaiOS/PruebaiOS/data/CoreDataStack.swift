//
//  CoreDataStack.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 25.10.21.
//

import Foundation
import UIKit
import CoreData

class CoreDataStack: NSObject {
    
    static let sharedInstance = CoreDataStack()
    private override init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PruebaiOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    //--------------------------------------------------------------------
    //
    //Returns the current Persistent Container for CoreData
     func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
     }
    //--------------------------------------------------------------------
    //
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //--------------------------------------------------------------------
    // Delete ALL Movies From CoreData
    func deleteAllMovies(path: Path) {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: getEntity(path: path))
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            try getContext().execute(deleteALL)
            saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }
    //--------------------------------------------------------------------
    //
    func existMovie(movie: Movie, path: Path)->Bool{
        let context = persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: getEntity(path: path))
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    let id = data.value(forKey: "id") as! Int
                    if movie.id == id{
                        return true
                    }
                }
            } catch {
                print("Check existing movie failed")
            }
        return false
        }
    //--------------------------------------------------------------------
    //
    func getEntity(path: Path) -> String {
        switch path {
        case .popular:
            return "DBPopular"
        case .upcoming:
            return "DBUpcoming"
        case .toprated:
            return "DBTop"
        default:
            return ""
        }
    }
    //--------------------------------------------------------------------
    //
    func getMovies(path: Path)->[Movie]{
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        var movies = [Movie]()
        let entity = getEntity(path: path)
        print("get from \(entity)")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                print("Size: \(result.count)")
                for data in result as! [NSManagedObject] {
                    let id = data.value(forKey: "id") as! Int
                    let title = data.value(forKey: "title") as! String
                    let backdropPath = data.value(forKey: "backdropPath") as! String?
                    let overview = data.value(forKey: "overview") as! String
                    let releaseDate = data.value(forKey: "releaseDate") as! String
                    let posterPath = data.value(forKey: "posterPath") as! String
                    let voteCount = data.value(forKey: "voteCount") as! Int
                    let voteAverage = data.value(forKey: "voteAverage") as! Double
                    let popularity = data.value(forKey: "popularity") as! Double
                    
                    let movie = Movie(backdropPath: backdropPath, id: id, overview: overview, popularity: popularity, posterPath: posterPath, releaseDate: releaseDate, title: title, voteAverage: voteAverage, voteCount: voteCount)
                    movies.append(movie)
                }
            } catch {
                print("Get movies Failed")
            }
        return movies
    }
    //--------------------------------------------------------------------
    //
    func saveMovies(category: Path, movies : [Movie]){
        switch category{
        case .popular:
            savePopular(category: category, movies : movies)
        case .upcoming:
            saveUpcoming(category: category, movies : movies)
        case .toprated:
            saveTop(category: category, movies : movies)
        case .search:
            print("")
        default:
            print("No found to save movies")
        }
    }
    //--------------------------------------------------------------------
    //
    private func savePopular(category: Path, movies : [Movie]) {
        let context = getContext()
        movies.forEach{(data) in
            if !CoreDataStack.sharedInstance.existMovie(movie: data, path: category){
                let entity = DBPopular(context: context)
                entity.id = Int32(data.id)
                entity.title = data.title
                entity.overview = data.overview
                entity.voteCount = Int32(data.voteCount)
                entity.posterPath = data.posterPath
                entity.voteAverage = data.voteAverage
                entity.backdropPath = data.backdropPath
                entity.releaseDate = data.releaseDate
            }
        }
        do{
            try context.save()
            print("DB Add to Popular")
        }catch{
            print(error.localizedDescription)
        }
    }
    //--------------------------------------------------------------------
    //
    private func saveUpcoming(category: Path, movies : [Movie]) {
        let context = getContext()
        movies.forEach{(data) in
            if !CoreDataStack.sharedInstance.existMovie(movie: data, path: category){
                let entity = DBUpcoming(context: context)
                entity.id = Int32(data.id)
                entity.title = data.title
                entity.overview = data.overview
                entity.voteCount = Int32(data.voteCount)
                entity.posterPath = data.posterPath
                entity.voteAverage = data.voteAverage
                entity.backdropPath = data.backdropPath
                entity.releaseDate = data.releaseDate
            }
        }
        do{
            try context.save()
            print("DB Add to Upcoming")
        }catch{
            print(error.localizedDescription)
        }
    }
    //--------------------------------------------------------------------
    //
    private func saveTop(category: Path, movies : [Movie]) {
        let context = getContext()
        movies.forEach{(data) in
            if !CoreDataStack.sharedInstance.existMovie(movie: data, path: category){
                let entity = DBTop(context: context)
                entity.id = Int32(data.id)
                entity.title = data.title
                entity.overview = data.overview
                entity.voteCount = Int32(data.voteCount)
                entity.posterPath = data.posterPath
                entity.voteAverage = data.voteAverage
                entity.backdropPath = data.backdropPath
                entity.releaseDate = data.releaseDate
            }
        }
        do{
            try context.save()
            print("DB Add to Toprated")
        }catch{
            print(error.localizedDescription)
        }
    }
}

extension CoreDataStack {
    
    func applicationDocumentsDirectory() {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "yo.BlogReaderApp" in the application's documents directory.
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}
