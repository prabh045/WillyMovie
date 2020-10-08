//
//  MovieDetailController.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 06/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    var movieId: String?
    var movieDetailViewModel = MovieDetailViewModel()
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        runTimeLabel.layer.cornerRadius = 10
        runTimeLabel.layer.masksToBounds = true
        
        movieDetailViewModel.fetchMovieDetails(movieId: movieId!)
        
        movieDetailViewModel.title.bind { [weak self] (title) in
            DispatchQueue.main.async {
                self?.movieTitleLabel.text = title
            }
        }
        
        movieDetailViewModel.genre.bind { [weak self] (genre) in
            DispatchQueue.main.async {
                self?.movieGenreLabel.text = genre
            }
        }
        
        movieDetailViewModel.posterUrl.bind { [weak self] (posterUrl) in
            let url = URL(string: posterUrl)
            DispatchQueue.main.async {
                self?.moviePoster.kf.setImage(with: url)
            }
        }
        
        movieDetailViewModel.actors.bind { [weak self] (actors) in
            DispatchQueue.main.async {
                self?.actorsLabel.text = actors
            }
        }
        
        movieDetailViewModel.ratings.bind { [weak self](ratings) in
            DispatchQueue.main.async {
                self?.ratingsLabel.attributedText = ratings
            }
        }
        
        movieDetailViewModel.runTime.bind { [weak self] (runTime) in
            DispatchQueue.main.async {
                self?.runTimeLabel.text = runTime
            }
        }
        
        movieDetailViewModel.plot.bind { [weak self] (plot) in
            DispatchQueue.main.async {
                self?.moviePlot.text = plot
            }
        }
    }
}
