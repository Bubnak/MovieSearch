//
//  ModelTests.swift
//  MoviestTests
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import XCTest
@testable import MovieSearch

class ModelTests: XCTestCase {

    enum FileType {
        case movie
        case movielist
    }

    func JSONFrom(fileType: FileType) -> Data? {
        let fileName: String
        switch fileType {
        case .movie:
            fileName = "movie"
        case .movielist:
            fileName = "movielist"
        }

        let pathURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json")
        guard let url = pathURL else {
            XCTFail("There is no such a file '\(fileName)")
            return nil
        }

        guard let data = try? Data.init(contentsOf: url) else {
            XCTFail("Cannot convert json file to data")
            return nil
        }
        return data
    }

    func testMovieModel() {
        guard let data = JSONFrom(fileType: .movie),
            let movie = try? JSONDecoder().decode(MovieDetail.self, from: data)else {
            XCTFail("Movie didn't mapped. Missing parameters (non optinals)")
            return
        }

      
        XCTAssert((type(of: movie) == MovieDetail.self), "Not a movie type")
         XCTAssertEqual("Captain Marvel", movie.Title, "Movie title is wrong. Should be 'Captain Marvel'")
               XCTAssertEqual("https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg", movie.Poster, "Poster is wrong.")
                            XCTAssertEqual("tt4154664", movie.imdbID, "imdbID  is wrong.")
          XCTAssertEqual("437,802", movie.imdbVotes, "imdbVotes  is wrong.")
          XCTAssertEqual("6.9", movie.imdbRating, "imdbRating  is wrong.")
           }
       

    func testMoviesListModel() {
        guard let data = JSONFrom(fileType: .movielist),
            
            let moviesResponse = try? JSONDecoder().decode(Results.self, from: data)else  {
                XCTFail("Movies Response didn't mapped. Missing parameters")
                return
        }

        XCTAssert((type(of: moviesResponse) == Results.self), "Not a movie type")
        XCTAssertEqual(10, moviesResponse.Search.count, "Movie not found")
        XCTAssertEqual("116", moviesResponse.totalResults, "Movies total count is wrong")
        XCTAssertEqual("True", moviesResponse.Response, "Movie not found")
       

        if let movie = moviesResponse.Search.first {
          

            XCTAssert((type(of: movie) == ResultOne.self), "Not a movie type")
            XCTAssertEqual("tt4154664", movie.imdbID, "imdbID is wrong")
            XCTAssertEqual("2019", movie.Year, "Movie year is wrong")
            XCTAssertEqual("Captain Marvel", movie.Title, "Movie Title is wrong. Should be '1995-10-20'")
        } else {
            XCTAssert(false, "Movies Response is wrong.")
        }

    }
    
}
