//
//  NetworkTests.swift
//  MoviestTests
//
//  Created by Bilal Arslan on 15.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import XCTest
@testable import Moviest

class NetworkTests: XCTestCase {

    enum RequestType {
        case topRated(page: Int)
        case search(query: String, page: Int)
    }

    func getRequestForType(type: RequestType) -> MovieRequest {
        switch type {
        case .topRated(let page):
            return TopMoviesRequest(page: page);
        case .search(let query, let page):
            return SearchMoviesRequest(query: query, page: page)
        }
    }

    func testTopRatedMoviesRequest() {
        let e = expectation(description: "Top rated movies")
        let request = getRequestForType(type: .topRated(page: 1))

        RequestManager.shared.perform(request) { (response: Response<MoviesResponse>) in
            switch response.result {
            case .success(let value):
                XCTAssertEqual(20, value.results?.count, "Movies Response current movies count is wrong. Should be '20'")
                XCTAssertEqual(1, value.page, "Movies Response current page is wrong. Should be '1'")

                if let movie = value.results?.first {
                    let date = DateFormatter.date(from: "1995-10-20", format: Constants.DateFormats.default)!

                    XCTAssertEqual(19404, movie.id, "Movie id is wrong. Should be '19404'")
                    XCTAssertEqual("Dilwale Dulhania Le Jayenge", movie.title, "Movie title is wrong. Should be 'Dilwale Dulhania Le Jayenge'")
                    XCTAssertEqual(date, movie.releaseDate, "Movie date is wrong. Should be '1995-10-20'")
                } else {
                    XCTAssert(false, "Movies Response current movies count is wrong.")
                }
            case .failure(let error):
                XCTAssertNil(error, "An error occured: \(error)")
            }

            // Fullfill the expectation
            e.fulfill()
        }

        waitForExpectations(timeout: 30.0) { (error: Error?) in
            print("Timeout Error: \(error.debugDescription)")
        }
    }

    func testSearchMoviesRequest() {
        let e = expectation(description: "Search result movies")
        let request = getRequestForType(type: .search(query: "Bilal", page: 1))

        RequestManager.shared.perform(request) { (response: Response<MoviesResponse>) in
            switch response.result {
            case .success(let value):
                XCTAssertEqual(5, value.results?.count, "Movies Response current movies count is wrong. Should be '5'")
                XCTAssertEqual(1, value.page, "Movies Response current page is wrong. Should be '1'")
                XCTAssertEqual(1, value.totalPages, "Movies Response total pages is wrong. Should be '1'")
                XCTAssertEqual(5, value.totalResults, "Movies Response total movies count is wrong. Should be '5'")

                if let movie = value.results?.first {
                    XCTAssertEqual(332718, movie.id, "Movie id is wrong. Should be '332718'")
                    XCTAssertEqual("Bilal: A New Breed of Hero", movie.title, "Movie title is wrong. Should be 'Bilal: A New Breed of Hero'")
                } else {
                    XCTAssert(false, "Movies Response current movies count is wrong.")
                }
            case .failure(let error):
                XCTAssertNil(error, "An error occured: \(error)")
            }

            // Fulfill the expectation
            e.fulfill()
        }

        waitForExpectations(timeout: 10.0) { (error: Error?) in
            print("Timeout Error: \(error.debugDescription)")
        }
    }
    
}
