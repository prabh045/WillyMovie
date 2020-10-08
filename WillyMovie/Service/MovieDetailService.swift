//
//  MovieDetailService.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 07/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation
import os.log

class MovieDetailService {
    
    static private let API_KEY = "55e6e58b"
    
    static func fetchMovie(movieId: String,completion: @escaping (MovieDetailModel?, Error?) -> Void) {
        let urlString = "http://www.omdbapi.com/?i=\(movieId)&apikey=\(API_KEY)"
        let url = URL(string: urlString)!
        
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
                let dataModel = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                completion(dataModel,nil)
            } catch let err{
                completion(nil,err)
                os_log(.info, log: .default, "Error in converting Data")
            }
            
        }.resume()
    }
    
    
}

