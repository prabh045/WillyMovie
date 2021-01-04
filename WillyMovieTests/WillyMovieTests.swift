//
//  WillyMovieTests.swift
//  WillyMovieTests
//
//  Created by Prabhdeep Singh on 06/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import XCTest
@testable import WillyMovie

class WillyMovieTests: XCTestCase {
    
    //Just a simple test case
    //Should pass when there is mismatch between keys
//    func testDecoding_whenMissingType_itThrows() {
//        XCTAssertThrowsError(try JSONDecoder().decode(MovieModel.self, from: fixtureMissingType)) { error in
//            if case .keyNotFound(let key, _)? = error as? DecodingError {
//                XCTAssertEqual("Search", key.stringValue)
//            } else {
//                XCTFail("Expected '.keyNotFound' but got \(error)")
//            }
//        }
//
//    }
    
    var sut: MovieViewModel?
    var mockMovieService: MockMovieService?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockMovieService = MockMovieService()
        sut = MovieViewModel(movieApi: mockMovieService!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockMovieService = nil
        super.tearDown()
    }
    
    //MARK: Test to check if fetchmovies method is being called in viewmodel
    func testFetchMoviesMethod() {
        sut?.retrieveMovies(movie: "abc")
        XCTAssert(mockMovieService!.didFetchMethodCalled, "Fetch movies method is not being called for some reason")
    }
    
    func testFailedRequest() {
        
        //Given
        let error = ApiError.noResponse
        
        //When
        sut?.retrieveMovies(movie: "abc")
        mockMovieService!.fetchFailed(error: error)
        
        //indicator should be hidden and its value must ne set to false
        //Here alert would be shown and tested
        XCTAssertFalse(sut!.shouldShowIndicator.value, "Indicator bool must be set to false")
    }
    
    func testSuccessRequest() {
        //Given
        let data = mockData
        
        //When
        sut?.retrieveMovies(movie: "abc")
        mockMovieService!.fetchSuccess(mockdata: data)
        
        XCTAssertTrue(sut!.getMovieCount()>0, "Movies count must be greater than zero")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

private let mockData = Data("""
{
    "Search": [{
        "Title": "The Avengers",
        "Year": "2012",
        "imdbID": "tt0848228",
        "Type": "movie",
        "Poster": "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg"
    },{
        "Title": "Avengers: Endgame",
        "Year": "2019",
        "imdbID": "tt4154796",
        "Type": "movie",
        "Poster": "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_SX300.jpg"
    }],
    "totalResults": "107",
    "Response": "True"
}
""".utf8)
