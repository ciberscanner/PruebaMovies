//
//  MoviesConfigurator.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 21.10.21.
//

import Foundation

protocol MoviesConfiguratorProtocol {
    func configure(with viewController: MoviesViewController)
}

class MoviesConfigurator: MoviesConfiguratorProtocol {
    func configure(with viewController: MoviesViewController) {
        //let presenter = MoviesPresenter()
        
        let router = MoviesRouter(viewController: viewController)
        
        //var view: MoviesViewProtocol = ViewController()
        var presenter: MoviesPresenterProtocol = MoviesPresenter()
        let interactor: MoviesInteractorProtocol = MoviesInteractor()
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        
    }
}
