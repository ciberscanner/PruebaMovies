//
//  DetailConfigurator.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 22.10.21.
//

import Foundation

protocol DetailConfiguratorProtocol {
    func configure(with viewController: DetailViewController)
}

class DetailConfigurator: DetailConfiguratorProtocol {
    func configure(with viewController: DetailViewController) {
        //let presenter = DetailPresenter()
        
        let router = DetailRouter(viewController: viewController)
        
        //var view: DetailViewProtocol = ViewController()
        var presenter: DetailPresenterProtocol = DetailPresenter()
        let interactor: DetailInteractorProtocol = DetailInteractor()
        
        viewController.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        
    }
}
