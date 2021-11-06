//
//  MovieTableViewCell.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 21.10.21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    //--------------------------------------------------------------------
    //Variables
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieVoteAverage: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    //--------------------------------------------------------------------
    //
    func setCell(item: Movie) {
        movieDate.text = item.releaseDate
        movieTitle.text = item.title
        movieOverview.text = item.overview
        movieVoteAverage.text = "\(item.voteAverage)"
        
        DispatchQueue.main.async {
            self.moviePoster.loadImageUsingCacheWithURLString("\(Domain.image.rawValue)\(item.posterPath ?? "")", placeHolder: UIImage(named: "backpicture"))
        }
    }
}
