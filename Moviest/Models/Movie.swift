//
//  Movie.swift
//  Moviest
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

struct Movie: Codable {

    var id: Int
    var title: String
    var posterURL: String?
    var overview: String?
    var releaseDate: String?
    var originalTitle: String?
    var originalLanguage: String?
    var genreIDs: [Int]?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var voteAverage: Double?
    var isAdult: Bool?
    var isVideo: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterURL = "poster_path"
        case overview
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case genreIDs = "genre_ids"
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case isVideo = "video"
        case isAdult = "adult"
    }

}

extension Movie: JSONCodable { }

extension Movie: ViewBidable {

    func getTitle() -> String {
        return title
    }

    func getSubtitle() -> String {
        return ""
    }

    func getImageURL() -> URL? {
        return nil
    }

    func getSubText() -> String? {
        return overview
    }

}

/*
 -- Incoming Movie JSON --
 {
    "vote_count": 2822,
    "id": 268,
    "video": false,
    "vote_average": 7.1,
    "title": "Batman",
    "popularity": 17.223516,
    "poster_path": "/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg",
    "original_language": "en",
    "original_title": "Batman",
    "genre_ids": [
        14,
        28
    ],
    "backdrop_path": "/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg",
    "adult": false,
    "overview": "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.",
    "release_date": "1989-06-23"
 }
 */
