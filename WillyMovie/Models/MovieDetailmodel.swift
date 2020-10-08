//
//  MovieDetailmodel.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 07/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct MovieDetailModel: Codable{
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let posterUrl: String
    let runtime: String
    let genre: String
    let actors: String
    let ratings: String
    let plot: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case posterUrl = "Poster"
        case runtime = "Runtime"
        case genre = "Genre"
        case actors = "Actors"
        case ratings = "imdbRating"
        case plot = "Plot"
    }
}
