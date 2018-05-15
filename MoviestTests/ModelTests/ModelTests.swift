//
//  ModelTests.swift
//  MoviestTests
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import XCTest
@testable import Moviest

class ModelTests: XCTestCase {

    enum FileType {
        case movie
        case topRated
    }

    func JSONFrom(fileType: FileType) -> Data? {
        let fileName: String!
        switch fileType {
        case .movie:
            fileName = "movie"
        case .topRated:
            fileName = "topRated"
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
        let movie = Movie(jsonData: data) else {
            XCTFail("Movie didn't mapped. Missing parameters (non optinals)")
            return
        }

        XCTAssert((type(of: movie) == Movie.self), "Not a movie type")
        XCTAssertEqual(movie.title, "Batman", "Movie title is wrong. Should be 'Batman'")
        XCTAssertEqual(movie.id, 268, "Movie id is wrong. Should be '268'")
        XCTAssertEqual(movie.voteCount, 2822, "Movie vote count is wrong. Should be '2822'")
        XCTAssertEqual(movie.popularity, 17.223516, "Movie popularity is wrong. Should be '17.223516'")
    }

    func testMoviesResponseModel() {
        guard let data = JSONFrom(fileType: .topRated),
            let moviesResponse = MoviesResponse(jsonData: data) else {
                XCTFail("Movies Response didn't mapped. Missing parameters (non optinals)")
                return
        }

        XCTAssert((type(of: moviesResponse) == MoviesResponse.self), "Not a movie type")
        XCTAssertEqual(moviesResponse.results.count, 20, "Movies Response current movies count is wrong. Should be '20'")
        XCTAssertEqual(moviesResponse.page, 1, "Movies Response current page is wrong. Should be '1'")
        XCTAssertEqual(moviesResponse.totalPages, 365, "Movies Response total pages is wrong. Should be '365'")
        XCTAssertEqual(moviesResponse.totalResults, 7289, "Movies Response total movies count is wrong. Should be '7289'")
    }
    
}
