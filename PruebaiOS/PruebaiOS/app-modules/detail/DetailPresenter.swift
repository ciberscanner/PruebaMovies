//
//  DetailPresenter.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 22.10.21.
//

import Foundation
import UIKit
import Alamofire
//--------------------------------------------------------------------
//
protocol DetailPresenterProtocol {
    var router: DetailRouterProtocol? {get set}
    var interactor: DetailInteractorProtocol? {get set}
    var view: DetailViewProtocol? {get set}
    
    func getDetail(id: Int, parameters: [String: String])
}
//--------------------------------------------------------------------
//
class DetailPresenter: DetailPresenterProtocol {
    //--------------------------------------------------------------------
    //Variables
    var router: DetailRouterProtocol?
    var interactor: DetailInteractorProtocol?
    var view: DetailViewProtocol?
    //--------------------------------------------------------------------
    //
    func getDetail(id: Int, parameters: [String: String]) {
        if !Reachability.isConnectedToNetwork(){
            print("Movies, Internet Connection not Available!")
            return
        }
        interactor?.getDetail(id: id, parameters: parameters){[weak self] result in
            switch result {
            case let .success(list):
                if !list.videos.results.isEmpty {
                    self?.view?.setVideos(with: list)
                } else{
                    self?.view?.setVideos(with: list)
                    print("The movie with id: \(id) is empty")
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
