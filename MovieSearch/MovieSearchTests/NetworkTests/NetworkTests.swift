//
//  NetworkTests.swift
//  MoviestTests
//
//  Created by Bilal Arslan on 15.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import XCTest
@testable import MovieSearch

class NetworkTests: XCTestCase {



     func testSearchMoviesRequest() {
           let e = expectation(description: "Search result movies")
           let querySearch = "Captain Marvel"
        let service = Service()
        
        service.urlSessionSearchList(with: querySearch){ (res) in
            switch res {
            case .success(let values):
                XCTAssertEqual(116, values.count, "Movies Response current movies count is wrong. Should be '116'")
                
                  if let value = values.first {
                    XCTAssertEqual("tt4154664", value.imdbID, "imdbID is wrong")
                    XCTAssertEqual("2019", value.Year, "Movie year is wrong")
                    XCTAssertEqual("Captain Marvel", value.Title, "Movie Title is wrong. Should be Captain Marvel")
                   
                    }
                
            case .failure(let error):
                XCTAssertNil(error, "An error occured: \(error)")
            }}
              e.fulfill()
           
    waitForExpectations(timeout: 10.0) { (error: Error?) in
        print("Timeout Error: \(error.debugDescription)")
    }

    }
    
    func testMoviesDetailRequest() {
           let e = expectation(description: "Movie Detail result ")
           let movieId = "tt4154664"
        let service = Service()
        service.urlSessionSearchDetails(with: movieId){ (res) in
            switch res {
            case .success(let movie):
                XCTAssert((type(of: movie) == MovieDetail.self), "Not a movie type")
                XCTAssertEqual("Captain Marvel", movie.Title, "Movie title is wrong. Should be 'Captain Marvel'")
                XCTAssertEqual("https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg", movie.Poster, "Poster is wrong.")
                XCTAssertEqual("tt41546643", movie.imdbID, "imdbID  is wrong.")
                XCTAssertEqual("437,802", movie.imdbVotes, "imdbVotes  is wrong.")
                XCTAssertEqual("6.9", movie.imdbRating, "imdbRating  is wrong.")
                
            case .failure(let error):
                XCTAssertNil(error, "An error occured: \(error)")
            }
            
        }
              e.fulfill()
           
    waitForExpectations(timeout: 10.0) { (error: Error?) in
        print("Timeout Error: \(error.debugDescription)")
    }

    }
    
}
