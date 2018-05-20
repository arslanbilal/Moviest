//
//  TopMoviesRequest.swift
//  Moviest
//
//  Created by Bilal Arslan on 15.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

struct TopMoviesRequest: MovieRequest {

    // MovieRequest protocol variables
    var path: String = "/movie/top_rated"

    var parameters: [String : Any] {
        return [
            "page": page
        ]
    }

    // Class variables
    private let page: Int

    // Initializer
    init(page: Int) {
        self.page = page
    }
}
