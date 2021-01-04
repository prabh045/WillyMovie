//
//  MockMovieService.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 31/12/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

class MockMovieService: MovieApi {
    var didFetchMethodCalled: Bool = false
    var completion: ((MovieModel?, Error?) -> Void)!
    
    func fetchMovies(movie: String, completion: @escaping (MovieModel?, Error?) -> Void) {
        didFetchMethodCalled = true
        self.completion = completion
    }
    
    func fetchFailed(error: Error) {
        completion(nil,error)
    }
    
    func fetchSuccess(mockdata: Data) {
        let dataModel = try? JSONDecoder().decode(MovieModel.self, from: mockdata)
        completion(dataModel,nil)
    }
    
    
}
