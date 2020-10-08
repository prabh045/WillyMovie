//
//  MovieModel.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 06/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    
    let search: Array<MovieElement>
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct MovieElement: Codable {
    
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let posterUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case posterUrl = "Poster"
    }
    
}
