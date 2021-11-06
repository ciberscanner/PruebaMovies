//
//  MoviesRouter.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 21.10.21.
//

import Foundation
import UIKit

typealias EntryPoint = MoviesViewProtocol & UIViewController

protocol MoviesRouterProtocol {
    //var view: MoviesViewController{get set}
    
    func showDetail(movie: Movie)
}

class MoviesRouter: MoviesRouterProtocol {
    //--------------------------------------------------------------------
    //Variables
    weak var view: MoviesViewController?
    //--------------------------------------------------------------------
    //Constructor
    init(viewController: MoviesViewController) {
        view = viewController
    }
    
    func showDetail(movie: Movie) {
        DispatchQueue.main.async {
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(identifier: "detailViewController")as! DetailViewController
            nextVC.movie = movie
            self.view!.show(nextVC, sender: self)*/
            
            
            let vc = DetailViewController()
            vc.movie = movie
            
            /*if let navCtrl = self.view
            {
               navCtrl.pushViewController(vc, animated: true)
            }
            else
            {
                let navCtrl = UINavigationController(rootViewController: vc)
                self.view!.present(navCtrl, animated: true, completion: nil)
            }

            
            self.view?.present(vc, animated: true)*/
            
            let navCtrl = UINavigationController(rootViewController: vc)
            self.view!.present(navCtrl, animated: true, completion: nil)
        }
    }
}
