//
//  CoreDataTest.swift
//  PruebaiOSTests
//
//  Created by Diego Fernando Serna Salazar on 05.11.21.
//

import XCTest
@testable import PruebaiOS

class CoreDataStackTest: XCTestCase {
    //--------------------------------------------------------------------
    //Variables
    //--------------------------------------------------------------------
    //Constructor
    override class func setUp() {
        super.setUp()
    }
    //--------------------------------------------------------------------
    //
    override class func tearDown() {
        super.tearDown()
        CoreDataStack.sharedInstance.deleteAllMovies(path: Path.popular)
        CoreDataStack.sharedInstance.deleteAllMovies(path: Path.toprated)
        CoreDataStack.sharedInstance.deleteAllMovies(path: Path.upcoming)
    }
    //--------------------------------------------------------------------
    //
    func testSavePopular(){
        let category = Path.popular
        let movies = getMoviesExample(path: category)
        CoreDataStack.sharedInstance.deleteAllMovies(path: category)
        CoreDataStack.sharedInstance.saveMovies(category: category, movies: movies)
        let popular = CoreDataStack.sharedInstance.getMovies(path: category)
        XCTAssertEqual(5, popular.count)
    }
    //--------------------------------------------------------------------
    //
    func testSaveTop(){
        let category = Path.toprated
        let movies = getMoviesExample(path: category, quantity: 6)
        CoreDataStack.sharedInstance.deleteAllMovies(path: category)
        CoreDataStack.sharedInstance.saveMovies(category: category, movies: movies)
        let popular = CoreDataStack.sharedInstance.getMovies(path: category)
        XCTAssertEqual(6, popular.count)
    }
    //--------------------------------------------------------------------
    //
    func testSaveUpcoming(){
        let category = Path.upcoming
        let movies = getMoviesExample(path: category, quantity: 7)
        CoreDataStack.sharedInstance.deleteAllMovies(path: category)
        CoreDataStack.sharedInstance.saveMovies(category: category, movies: movies)
        let popular = CoreDataStack.sharedInstance.getMovies(path: category)
        XCTAssertEqual(7, popular.count)
    }
    //--------------------------------------------------------------------
    //
    func testExistMovie(){
        let category = Path.upcoming
        let movies = getMoviesExample(path: category)
        CoreDataStack.sharedInstance.deleteAllMovies(path: category)
        CoreDataStack.sharedInstance.saveMovies(category: category, movies: movies)
        let exist = CoreDataStack.sharedInstance.existMovie(movie: movies[3], path: category)
        XCTAssertTrue(exist)
    }
}
