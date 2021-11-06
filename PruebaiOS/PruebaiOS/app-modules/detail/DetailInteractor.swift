//
//  DetailInteractor.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 22.10.21.
//

import Foundation
import Alamofire
//--------------------------------------------------------------------
//
protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? {get set}
    func getDetail(id: Int, parameters: [String: String], completion: @escaping (Result<MovieDetailRequest, NetworkingError>) -> Void)
}
//--------------------------------------------------------------------
//
class DetailInteractor: DetailInteractorProtocol {
    //--------------------------------------------------------------------
    //Variables
    var presenter: DetailPresenterProtocol?
    //--------------------------------------------------------------------
    //
    func getDetail(id: Int, parameters: [String: String], completion: @escaping (Result<MovieDetailRequest, NetworkingError>) -> Void) {
        let path = "\(Path.detail.rawValue)\(id)"
        Networking(path: String(format: path), parameters: parameters, method: .get).execute(withCodable: MovieDetailRequest.self) { (result) in
            completion(result)
        }
    }
}
