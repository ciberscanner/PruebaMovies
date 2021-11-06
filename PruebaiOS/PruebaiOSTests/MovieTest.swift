//
//  MovieTest.swift
//  PruebaiOSTests
//
//  Created by Diego Fernando Serna Salazar on 05.11.21.
//

import XCTest
import Mocker

@testable import PruebaiOS

class MovieTest: XCTestCase {
    //--------------------------------------------------------------------
    //Variables
    var presenter : MoviesPresenter?
    var interactor : MoviesInteractor!
    var constructor : MoviesConfigurator!
    let images = ["/2jVVDtDaeMxmcvrz2SNyhMcYtWc.jpg",
                  "/m6XWQpT0biTpe5wBGWd60RXmtEX.jpg",
                  "/suaooqn1Mnv60V19MoGxneMupJs.jpg",
                  "/54rcNkxmG3EEBU5GuI3NL0W6gz.jpg"]
    let view = MoviesMockView()
    //--------------------------------------------------------------------
    //
    override func setUp() {
        Mocker.mode = .optout
        presenter = view.presenter as? MoviesPresenter
        interactor = view.interactor
    }
    //--------------------------------------------------------------------
    //
    override func tearDown() {
        Mocker.removeAll()
        Mocker.mode = .optout
        super.tearDown()
    }
    //--------------------------------------------------------------------
    //
    func testGetMovies(){
        let path = Path.upcoming
        let apiEndPoit = URL(string: "\(Domain.develop.rawValue)\(path.rawValue)")!
        Mock(url: apiEndPoit, dataType: .json, statusCode: 200, data: [.get: DataExample.getTopMovies()]).register()

        Mock(url: URL(string: "\(Domain.image.rawValue)\(images [0])")!, dataType: .imagePNG, statusCode: 200, data: [
            .get: DataExample.imageFileUrl.data
        ]).register()
        Mock(url: URL(string: "\(Domain.image.rawValue)\(images [1])")!, dataType: .imagePNG, statusCode: 200, data: [
            .get: DataExample.imageFileUrl.data
        ]).register()
        Mock(url: URL(string: "\(Domain.image.rawValue)\(images [2])")!, dataType: .imagePNG, statusCode: 200, data: [
            .get: DataExample.imageFileUrl.data
        ]).register()
        Mock(url: URL(string: "\(Domain.image.rawValue)\(images [3])")!, dataType: .imagePNG, statusCode: 200, data: [
            .get: DataExample.imageFileUrl.data
        ]).register()
        
        let requestExpectation = expectation(description: "Request should finish")
        
        interactor.getMovies(category: path, parameters: parametersMovie()){ result in
            switch result{
            case let .success(moviesrequest):
                XCTAssertGreaterThan(moviesrequest.results.count, 15)
                requestExpectation.fulfill()
            case .failure:
                XCTFail("Request should succeed")
            }
        
        }
        wait(for: [requestExpectation], timeout: 10.0)
    }
}
