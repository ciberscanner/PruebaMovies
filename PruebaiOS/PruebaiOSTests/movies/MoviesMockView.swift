//
//  UserMockView.swift
//  PruebaiOSTests
//
//  Created by Diego Fernando Serna Salazar on 05.11.21.
//

import Foundation

@testable import PruebaiOS

class MoviesMockView: MoviesViewProtocol{
    //--------------------------------------------------------------------
    //Variables
    var presenter: MoviesPresenterProtocol?
    var interactor : MoviesInteractor!
    //--------------------------------------------------------------------
    //
    init() {
        presenter = MoviesPresenter()
        interactor = MoviesInteractor()
        interactor.presenter = presenter
        
        presenter?.view = self
        presenter?.interactor = interactor
    }
    //--------------------------------------------------------------------
    //
    func showMovies(with moviesRequest: MoviesRequest) {
        print("show movies request is ok")
    }
    
    func showMovies(with movies: [Movie]) {
        print("show movies local is ok")
    }
}
