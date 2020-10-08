//
//  MoveDetailViewModel.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 07/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation
import UIKit.UIFont

class MovieDetailViewModel {
    
    private var movieDetailModel: MovieDetailModel!
    
    var title = Box("")
    var genre = Box("")
    var actors = Box("")
    var ratings = Box(NSAttributedString())
    var posterUrl = Box("")
    var plot = Box("")
    var runTime = Box("")
    
//    var genre: String {
//        return movieDetailModel?.genre ?? ""
//    }
//
//    var actors: String {
//        return movieDetailModel?.genre ?? ""
//    }
//
//    var ratings: String {
//        return movieDetailModel?.ratings ?? ""
//    }
//
//    var posterUrl: URL {
//        let url = movieDetailModel?.posterUrl
//        return URL(string: url!)!
//    }
//
//    var plot: String {
//        return movieDetailModel?.plot ?? ""
//    }
    
    func formatString(ratings: String) -> NSAttributedString {
        let ratingAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemYellow,
            NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 22)
        ] as [NSAttributedString.Key : Any]
        let ratingString = NSMutableAttributedString(string: ratings, attributes: ratingAttributes)
        let constRating = NSAttributedString(string: "/10")
        ratingString.append(constRating)
        return ratingString
        
    }
    
     func fetchMovieDetails(movieId: String) {
        MovieDetailService.fetchMovie(movieId: movieId) { (movieDetails, error) in
            if let error = error {
                print("Error receiving movie details \(error.localizedDescription)")
                return
            }
            self.movieDetailModel = movieDetails!
            self.title.value = self.movieDetailModel.title
            self.genre.value = self.movieDetailModel.genre
            self.actors.value = self.movieDetailModel.actors
            self.ratings.value = self.formatString(ratings: self.movieDetailModel.ratings)
            self.posterUrl.value = self.movieDetailModel.posterUrl
            self.plot.value = self.movieDetailModel.plot
            self.runTime.value = self.movieDetailModel.runtime
        }
    }
    
}
