//
//  AppConstants.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 16.10.21.
//

import Foundation
import Alamofire
//--------------------------------------------------------------------
//Variables
let LIMIT = 100
//--------------------------------------------------------------------
//
enum API: String {
    case KEY = "3b2c20f8313d1eeeac3a6b4cdca5bfb7"
    case TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYjJjMjBmODMxM2QxZWVlYWMzYTZiNGNkY2E1YmZiNyIsInN1YiI6IjU4YWM4NzgxYzNhMzY4NDliMDAxNDE2YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.myq761hMLFTpvK9YcxUXm7WwQYC9RwwtnIwhXqEWqkc"
}
//--------------------------------------------------------------------
//
let headers: HTTPHeaders = ["Authorization": "Bearer \(API.TOKEN.rawValue)",
                            "Content-Type": "application/json;charset=utf-8"]
//--------------------------------------------------------------------
//
enum LANG: String {
    case ES = "es-ES"
    case EN = "en-EN"
}
//--------------------------------------------------------------------
//
enum Domain: String {
    case develop = "https://api.themoviedb.org/3/"
    case production = "https://api.themoviedb.org/4/"
    case image = "https://image.tmdb.org/t/p/w500"
    case video = "https://www.youtube.com/embed"
}
//--------------------------------------------------------------------
//
enum Path: String {
    case popular = "movie/popular"
    case toprated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    case search = "search/movie"
    case detail = "movie/"
}
//--------------------------------------------------------------------
//
func parametersMovies(lang: LANG = .ES, page: Int = 1) -> [String: String] {
    return ["api_key": "\(API.KEY.rawValue)",
            "language": "\(lang.rawValue))",
            "page": "\(page)"]
}
//--------------------------------------------------------------------
//
func parametersFilter(lang: LANG = .ES, page: Int = 1, query: String) -> [String: String] {
    return ["api_key": "\(API.KEY.rawValue)",
            "language": "\(lang.rawValue))",
            "page": "\(page)",
            "query": "\(query)"]
}
//--------------------------------------------------------------------
//
func parametersMovie(lang: LANG = .ES) -> [String: String] {
    return ["api_key": "\(API.KEY.rawValue)",
            "language": "\(lang.rawValue)",
            "append_to_response": "videos"]
}
//--------------------------------------------------------------------
//
func showMessage(context: UIViewController, title:String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
    NSLog("The \"OK\" alert occured.")
    }))
    context.present(alert, animated: true, completion: nil)
}
