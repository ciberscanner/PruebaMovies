//
//  DetailRouter.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 22.10.21.
//

import Foundation
import UIKit

protocol DetailRouterProtocol {
}

class DetailRouter: DetailRouterProtocol {
    //--------------------------------------------------------------------
    //Variables
    weak var view: DetailViewController?
    //--------------------------------------------------------------------
    //Constructor
    init(viewController: DetailViewController) {
        view = viewController
    }
}
