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

        let date = DateFormatter.date(from: "1989-06-23", format: Constants.DateFormats.default)!

        XCTAssert((type(of: movie) == Movie.self), "Not a movie type")
        XCTAssertEqual("Batman", movie.title, "Movie title is wrong. Should be 'Batman'")
        XCTAssertEqual(268, movie.id, "Movie id is wrong. Should be '268'")
        XCTAssertEqual(date, movie.releaseDate, "Movie date is wrong. Should be '1989-06-23'")
        XCTAssertEqual(2822, movie.voteCount, "Movie vote count is wrong. Should be '2822'")
        XCTAssertEqual(17.223516, movie.popularity, "Movie popularity is wrong. Should be '17.223516'")
    }

    func testMoviesResponseModel() {
        guard let data = JSONFrom(fileType: .topRated),
            let moviesResponse = MoviesResponse(jsonData: data) else {
                XCTFail("Movies Response didn't mapped. Missing parameters (non optinals)")
                return
        }

        XCTAssert((type(of: moviesResponse) == MoviesResponse.self), "Not a movie type")
        XCTAssertEqual(20, moviesResponse.results.count, "Movies Response current movies count is wrong. Should be '20'")
        XCTAssertEqual(1, moviesResponse.page, "Movies Response current page is wrong. Should be '1'")
        XCTAssertEqual(365, moviesResponse.totalPages, "Movies Response total pages is wrong. Should be '365'")
        XCTAssertEqual(7289, moviesResponse.totalResults, "Movies Response total movies count is wrong. Should be '7289'")

        if let movie = moviesResponse.results.first {
            let date = DateFormatter.date(from: "1995-10-20", format: Constants.DateFormats.default)!

            XCTAssert((type(of: movie) == Movie.self), "Not a movie type")
            XCTAssertEqual("Dilwale Dulhania Le Jayenge", movie.title, "Movie title is wrong. Should be 'Dilwale Dulhania Le Jayenge'")
            XCTAssertEqual(19404, movie.id, "Movie id is wrong. Should be '268'")
            XCTAssertEqual(date, movie.releaseDate, "Movie date is wrong. Should be '1995-10-20'")
            XCTAssertEqual(1389, movie.voteCount, "Movie vote count is wrong. Should be '1389'")
            XCTAssertEqual(16.809409, movie.popularity, "Movie popularity is wrong. Should be '16.809409'")
        } else {
            XCTAssert(false, "Movies Response current movies count is wrong.")
        }

    }
    
}
