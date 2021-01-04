//
//  MockDataTask.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 01/01/21.
//  Copyright © 2021 Prabh. All rights reserved.
//

import Foundation

class MockSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var didResumeCalled = false
    
    func resume() {
        didResumeCalled = true
    }
}
