//
//  ViewController.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 21.10.21.
//

import UIKit

class ViewController: UIViewController {
    //--------------------------------------------------------------------
    //Variables
    let images = ["heart","star","binoculars","magnifyingglass"]
    //--------------------------------------------------------------------
    //Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //--------------------------------------------------------------------
    //
    override func viewDidAppear(_ animated: Bool) {
        self.createViewController()
    }
    //--------------------------------------------------------------------
    //
    func createViewController(){
        let tabBarVC = UITabBarController()
        let popular = MoviesViewController()
        popular.path = .popular
        popular.title = "Popular"
        let top = MoviesViewController()
        top.path = .toprated
        top.title = "Top Rated"
        let upcoming = MoviesViewController()
        upcoming.path = .upcoming
        upcoming.title = "Upcoming"
        let search = MoviesViewController()
        search.path = .search
        search.title = "Search"
        
        let nvpopular = UINavigationController(rootViewController:popular)
        let nvtop = UINavigationController(rootViewController:top)
        let nvupcoming = UINavigationController(rootViewController:upcoming)
        let nvsearch = UINavigationController(rootViewController:search)
        
        if Reachability.isConnectedToNetwork(){
            tabBarVC.setViewControllers([nvpopular,nvtop,nvupcoming,nvsearch], animated: false)
        }else{
            tabBarVC.setViewControllers([nvpopular,nvtop,nvupcoming], animated: false)
        }
        
        guard let items = tabBarVC.tabBar.items else{
            return
        }
        for x in 0..<items.count {
            items[x].image = UIImage (systemName: images[x])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: false)
        
    }
}
