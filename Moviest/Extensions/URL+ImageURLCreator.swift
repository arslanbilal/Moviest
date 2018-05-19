//
//  URL+ImageURLCreator.swift
//  Moviest
//
//  Created by Bilal Arslan on 16.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

enum ImageSize {
    case w92
    case ​w185
    case ​w500
    case w780

    func string() -> String {
        switch self {
        case .w92:
            return "/w92"
        case .​w185:
            return "/w185"
        case .​w500:
            return "/w500"
        case .w780:
            return "/w780"
        }
    }
}

extension URL {

    static private let baseURL = URL(string: "http://image.tmdb.org/t/p")!

    static func getMoviePosterURL(fromPath path: String, size: ImageSize) -> URL {
        var url = baseURL.appendingPathComponent(size.string())
        url = url.appendingPathComponent(path)
        return url
    }
    // http://image.tmdb.org/t/p/w92/2DtPSyODKWXluIRV7PVru0SSzja.jpg

}
