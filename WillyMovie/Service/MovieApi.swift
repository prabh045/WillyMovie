//
//  MovieApi.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 31/12/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

protocol MovieApi {
    func fetchMovies(movie: String,completion: @escaping (MovieModel?, Error?) -> Void)
}
