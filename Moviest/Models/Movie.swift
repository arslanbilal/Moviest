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
    private var posterPath: String?
    var overview: String?
    var releaseDate: Date?
    var originalTitle: String?
    var originalLanguage: String?
    var genreIDs: [Int]?
    private var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var voteAverage: Double?
    var isAdult: Bool?
    var isVideo: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        title = try container.decode(.title)
        posterPath = try? container.decode(.posterPath)
        overview = try? container.decode(.overview)
        releaseDate = try? container.decode(.releaseDate, transformer: DateTransformer())
        originalTitle = try? container.decode(.originalTitle)
        originalLanguage = try? container.decode(.originalLanguage)
        genreIDs = try? container.decode(.genreIDs)
        backdropPath = try? container.decode(.backdropPath)
        popularity = try? container.decode(.popularity)
        voteCount = try? container.decode(.voteCount)
        voteAverage = try? container.decode(.voteAverage)
        isVideo = try? container.decode(.isVideo)
        isAdult = try? container.decode(.isAdult)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try? container.encode(posterPath, forKey: .posterPath)
        try? container.encode(overview, forKey: .overview)
        if let date = releaseDate {
            try container.encode(date, forKey: .releaseDate, transformer: DateTransformer())
        }
        try? container.encode(originalTitle, forKey: .originalTitle)
        try? container.encode(originalLanguage, forKey: .originalLanguage)
        try? container.encode(genreIDs, forKey: .genreIDs)
        try? container.encode(backdropPath, forKey: .backdropPath)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(voteCount, forKey: .voteCount)
        try? container.encode(voteAverage, forKey: .voteAverage)
        try? container.encode(isVideo, forKey: .isVideo)
        try? container.encode(isAdult, forKey: .isAdult)
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
        guard let path = posterPath else {
            return nil
        }
        return URL.getMoviePosterURL(fromPath: path, size: .​w185)
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
