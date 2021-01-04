//
//  MockSession.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 01/01/21.
//  Copyright © 2021 Prabh. All rights reserved.
//

import Foundation

class MockSession: URLSessionProtocol {
    //to test of resume is called.
    var mockData = MockSessionDataTask()
    //to test if url the session received is same as which was passed in
    private (set) var givenUrl: URL?
    
    func dataTaskWith(_ url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        givenUrl = url
        return mockData
    }
}
