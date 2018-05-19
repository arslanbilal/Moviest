//
//  MoviesResponse.swift
//  Moviest
//
//  Created by Bilal Arslan on 15.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {

    private(set) var results: [Movie]?
    private(set) var page: Int?
    private(set) var totalResults: Int?
    private(set) var totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

}
