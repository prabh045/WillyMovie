//
//  HTTPClient.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 01/01/21.
//  Copyright © 2021 Prabh. All rights reserved.
//

import Foundation

class NetworkManager {
    private let session: URLSessionProtocol
    
    //providing it default value of URLSession becuase in prodution code we wont need mock values
    //DI Here t mock session
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func getData(with url: URL, completionHandler: @escaping DataTaskResult) {
        self.session.dataTaskWith(url, completionHandler: completionHandler).resume()
    }
}
