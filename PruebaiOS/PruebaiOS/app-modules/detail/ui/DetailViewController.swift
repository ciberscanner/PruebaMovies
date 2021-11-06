//
//  DetailViewController.swift
//  PruebaiOS
//
//  Created by Diego Fernando Serna Salazar on 22.10.21.
//

import UIKit
import youtube_ios_player_helper
import ViewAnimator

protocol DetailViewProtocol {
    var presenter: DetailPresenterProtocol? {get set}
    func setVideos(with movieDetail: MovieDetailRequest)
}


class DetailViewController: UIViewController, YTPlayerViewDelegate {
    //--------------------------------------------------------------------
    //Variables
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieReleased: UILabel!
    @IBOutlet weak var moviePopularity: UILabel!
    @IBOutlet weak var movieVoteCount: UILabel!
    @IBOutlet weak var movieVoteAverage: UILabel!
    @IBOutlet weak var movieBackdrop: UIImageView!
    @IBOutlet weak var back1: UIView!
    @IBOutlet weak var back2: UIView!
    @IBOutlet weak var back3: UIView!
    @IBOutlet weak var buttonVervideo: UIButton!
    @IBOutlet weak var viewMovie: YTPlayerView!
    
    var movie: Movie?
    var presenter: DetailPresenterProtocol?
    var configurator: DetailConfigurator = DetailConfigurator()
    //--------------------------------------------------------------------
    //constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMovie.delegate = self
        configurator.configure(with: self)
        setView(movie: movie!)
        back1.addShadow(shadowRadius: 1, cornerRadius: 10)
        back2.addShadow(shadowRadius: 1, cornerRadius: 10)
        back3.addShadow(shadowRadius: 1, cornerRadius: 10)
        buttonVervideo.addShadow(shadowRadius: 1, cornerRadius: 10)
    }
    //--------------------------------------------------------------------
    //
    func setView(movie: Movie) {
        movieOverview.text = movie.overview
        movieReleased.text = String((movie.releaseDate?.prefix(4))!) 
        moviePopularity.text = "\(movie.popularity)"
        movieVoteCount.text = "\(movie.voteCount)"
        movieVoteAverage.text = "\(movie.voteAverage)"
        movieBackdrop.downloaded(from: "\(Domain.image.rawValue)\(movie.backdropPath ?? "")")
        buttonVervideo.isHidden = true
        title = movie.title
        if !Reachability.isConnectedToNetwork(){
            buttonVervideo.isHidden = true
        }else{
            presenter?.getDetail(id: movie.id, parameters: parametersMovie())
        }
    }
    //--------------------------------------------------------------------
    //
    @IBAction func showVideo(_ sender: Any) {
        viewMovie.isHidden = false
        buttonVervideo.isHidden = true
    }
}

extension DetailViewController: DetailViewProtocol{
    func setVideos(with movieDetail: MovieDetailRequest) {
        if movieDetail.videos.results.count>0{
            viewMovie.load(withVideoId: movieDetail.videos.results[0].key)
            let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
            let zoomAnimation = AnimationType.zoom(scale: 0.2)
            let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
            buttonVervideo.isHidden = false
            UIView.animate(views: [buttonVervideo],
                           animations: [fromAnimation,zoomAnimation, rotateAnimation],
                           duration: 1)
        }
        else{
            buttonVervideo.isHidden = true
        }
    }
}
