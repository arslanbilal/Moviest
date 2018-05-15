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
        case movies
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testMovieModel() {
        // TODO: Change this to stub option
        guard let data = JSONFrom(fileType: .movie),
        let movie = Movie(jsonData: data) else {
            XCTFail("Movie didn't mapped. Missing parameters (non optinals)")
            return
        }

        XCTAssertEqual(movie.title, "Batman", "Movie title is wrong. Should be 'Batman'")
        XCTAssertEqual(movie.id, 268, "Movie id is wrong. Should be '268'")
        XCTAssertEqual(movie.voteCount, 2822, "Movie vote count is wrong. Should be '2822'")
        XCTAssertEqual(movie.popularity, 17.223516, "Movie popularity is wrong. Should be '17.223516'")
        XCTAssert((type(of: movie) == Movie.self), "Not a movie type")
    }

    func JSONFrom(fileType: FileType) -> Data? {
        let pathURL: URL?
        switch fileType {
        case .movie:
            pathURL = Bundle(for: type(of: self)).url(forResource: "movie", withExtension: "json")
        case .movies:
            pathURL = Bundle(for: type(of: self)).url(forResource: "movies", withExtension: "json")
        }

        guard let url = pathURL else {
            XCTFail("There is no such a file 'movie.json'")
            return nil
        }

        guard let data = try? Data.init(contentsOf: url) else {
            XCTFail("Cannot convert json file to data")
            return nil
        }
        return data
    }
    
}
