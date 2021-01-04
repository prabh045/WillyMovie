//
//  URLSessionProtocols.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 01/01/21.
//  Copyright © 2021 Prabh. All rights reserved.
//

import Foundation

//creating DataTaskResult similar to urlsession's datatask arguments
typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

//protocol so that we can use mock and real values
protocol URLSessionProtocol {
    func dataTaskWith(_ url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionProtocol {
    func dataTaskWith(_ url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let task = dataTask(with: url, completionHandler: completionHandler)
        return task
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }


