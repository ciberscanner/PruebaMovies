//
//  MoviesEntity.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 21.10.21.
//

import Foundation


// MARK: - MoviesRequest
struct MoviesRequest: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    //let adult: Bool
    let backdropPath: String?
    //let genreIDS: [Int]
    let id: Int
    //let originalLanguage, originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String
    //let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        //case adult
        case backdropPath = "backdrop_path"
        //case genreIDS = "genre_ids"
        case id
        //case originalLanguage = "original_language"
        //case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        //case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
