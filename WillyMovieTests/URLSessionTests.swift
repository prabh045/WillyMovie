//
//  URLSessionTests.swift
//  WillyMovieTests
//
//  Created by Prabhdeep Singh on 01/01/21.
//  Copyright © 2021 Prabh. All rights reserved.
//

import XCTest
@testable import WillyMovie

class URLSessionTests: XCTestCase {
    var sut: NetworkManager!
    var mockSession: MockSession!
   // var dataTask: MockSessionDataTask?
    
    override func setUp() {
        super.setUp()
        mockSession = MockSession()
        //dataTask = MockSessionDataTask()
        sut = NetworkManager(session: mockSession!)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testUrlReceived() throws{
        //Given
        let url = URL(string: "https://www.youtube.com/watch?v=hMAPyGoqQVw&list=RDMMgBRi6aZJGj4&index=9")
        
        //when
        sut.getData(with: try XCTUnwrap(url), completionHandler: { (_, _, _) in
        })
        
        XCTAssertEqual(mockSession.givenUrl, try XCTUnwrap(url))
    }
    
    func testRequestStarted() throws{
        //Given
        let url = URL(string: "https://www.youtube.com/watch?v=hMAPyGoqQVw&list=RDMMgBRi6aZJGj4&index=9")
        
        //when
        sut.getData(with: try XCTUnwrap(url), completionHandler: { (_, _, _) in
        })
        
        XCTAssert(mockSession.mockData.didResumeCalled)
    }
}
