//
//  AysncCallsTests.swift
//  WillyMovieTests
//
//  Created by Prabhdeep Singh on 31/12/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import XCTest
@testable import WillyMovie

class AysncCallsTests: XCTestCase {
    var sut: URLSession!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = URLSession(configuration: .default)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testAsyncRetrieval() {
        
        let urlString = "http://www.omdbapi.com/?s=avengers&apikey=55e6e58b"
        let url = URL(string: urlString)
        let testExpectation = expectation(description: "test expectation")
        var statusCode: Int?
        var responseError: Error?
        
        //not working
        XCTAssertNotNil(url, "Url must not be nil")
        
        sut.dataTask(with: url!) { (data, response, error) in
            
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            testExpectation.fulfill()
            
        }.resume()
        
        //Here it will not keep test running for 20 sec because expectation will always be fullfilled
        wait(for: [testExpectation], timeout: 20)
        
        XCTAssertNil(responseError, "Error : \(responseError!)")
        XCTAssertEqual(statusCode, 200, "Status code \(statusCode ?? -1)")
        
    }

}
