//
//  MoviesPresenter.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 21.10.21.
//

import Foundation
import UIKit
import Alamofire
//--------------------------------------------------------------------
//
protocol MoviesPresenterProtocol {
    var router: MoviesRouterProtocol? {get set}
    var interactor: MoviesInteractorProtocol? {get set}
    var view: MoviesViewProtocol? {get set}
    
    func getMovies(category: Path, parameters: [String: String])
    func getFilterMovies(category: Path, name: String)
    func showDetail(movie: Movie)
    
}
//--------------------------------------------------------------------
//
class MoviesPresenter: MoviesPresenterProtocol {
    //--------------------------------------------------------------------
    //Variables
    var router: MoviesRouterProtocol?
    var interactor: MoviesInteractorProtocol?
    var view: MoviesViewProtocol?
    //--------------------------------------------------------------------
    //
    func getMovies(category: Path, parameters: [String: String]) {
        if !Reachability.isConnectedToNetwork(){
            print("Movies, Internet Connection not Available!")
            let movies = interactor?.getLocalMovies(category: category)
            view?.showMovies(with: movies!)
            return
        }
        interactor?.getMovies(category: category, parameters: parameters){[weak self] result in
            switch result {
            case let .success(list):
                if !list.results.isEmpty {
                    //print("PATH: \(category.rawValue) TOTAL PAGES: \(list.totalPages), PAGE: \(list.page)")
                    self?.interactor?.saveMovies(category: category, movies : list.results)
                    self?.view?.showMovies(with: list)
                } else{
                    self?.view?.showMovies(with: list)
                    print("The movie list with path: \(category.rawValue) is empty")
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
    //--------------------------------------------------------------------
    //
    func getFilterMovies(category: Path, name: String) {
        let movies = interactor?.getFilterMovies(category: category, name: name)
        view?.showMovies(with: movies!)
    }
    //--------------------------------------------------------------------
    //
    func showDetail(movie: Movie) {
        router?.showDetail(movie: movie)
    }
}
