//
//  MoviesInteractor.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 21.10.21.
//

import Foundation
import Alamofire
import CoreData
//--------------------------------------------------------------------
//
protocol MoviesInteractorProtocol: AnyObject {
    var presenter: MoviesPresenterProtocol? {get set}
    func getMovies(category: Path, parameters: [String: String], completion: @escaping (Result<MoviesRequest, NetworkingError>) -> Void)
    func getFilterMovies(category: Path, name: String)-> [Movie]
    func saveMovies(category: Path, movies : [Movie])
    func getLocalMovies(category: Path) -> [Movie]
}
//--------------------------------------------------------------------
//
class MoviesInteractor: MoviesInteractorProtocol {
    //--------------------------------------------------------------------
    //Variables
    var presenter: MoviesPresenterProtocol?
    //--------------------------------------------------------------------
    //
    func getMovies(category: Path, parameters: [String: String], completion: @escaping (Result<MoviesRequest, NetworkingError>) -> Void) {
        Networking(path: String(format: category.rawValue), parameters: parameters, method: .get).execute(withCodable: MoviesRequest.self) { (result) in
            completion(result)
        }
    }
    //--------------------------------------------------------------------
    //
    func getFilterMovies(category: Path, name: String)-> [Movie]{
        let movies = CoreDataStack.sharedInstance.getMovies(path: category)
        let filterMovies = movies.filter({(movie:Movie) ->
                                            Bool in let name = movie.title.range(of: name, options: NSString.CompareOptions.caseInsensitive)
                                            return name != nil})
        return filterMovies
    }
    //--------------------------------------------------------------------
    //
    func getLocalMovies(category: Path) -> [Movie]{
        let movies = CoreDataStack.sharedInstance.getMovies(path: category)
        return movies
    }
    //--------------------------------------------------------------------
    //
    func saveMovies(category: Path, movies : [Movie]) {
        //CoreDataStack.sharedInstance.deleteAllMovies(path: category)
        CoreDataStack.sharedInstance.saveMovies(category: category, movies: movies)
    }
}
