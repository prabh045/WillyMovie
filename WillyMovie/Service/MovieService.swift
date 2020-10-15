//
//  MovieService.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 06/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation
import os.log

class MovieService {
    
    static private let API_KEY = "55e6e58b"
    
    static func fetchMovies(movie: String,completion: @escaping (MovieModel?, Error?) -> Void) {
        let movieString = movie.replacingOccurrences(of: " ", with: "")
        let urlString = "http://www.omdbapi.com/?s=\(movieString)&apikey=\(API_KEY)"
        guard let url = URL(string: urlString) else {
            completion(nil,nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                os_log(.debug, log: .default, "Error Fetching data from server")
                return
            }
            
            guard let data = data else {
                os_log(.debug, log: .default, "No Data available")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                os_log(.debug, log: .default, "No Response")
                return
            }
            
            guard response.statusCode == 200 else {
                os_log(.debug, log: .default, "Wrong Status Code")
                return
            }
            //let stringData = String(data: data, encoding: .utf8)
            do {
                let dataModel = try JSONDecoder().decode(MovieModel.self, from: data)
                completion(dataModel,nil)
                
            } catch let err{
                completion(nil,err)
                os_log(.info, log: .default, "Error in converting Data")
            }
            
        }.resume()
    }
    
    
}


