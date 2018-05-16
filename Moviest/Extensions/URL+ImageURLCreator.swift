//
//  URL+ImageURLCreator.swift
//  Moviest
//
//  Created by Bilal Arslan on 16.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

enum ImageSize: String {
    case w92 = "/w92"
    case ​w185 = "​/w185"
    case ​w500 = "​/w500"
    case w780 = "/w780"

    // http://image.tmdb.org/t/p/w92/2DtPSyODKWXluIRV7PVru0SSzja.jpg
}

extension URL {

    static private let baseURL = URL(string: "http://image.tmdb.org/t/p/")!

    static func getMoviePosterURL(fromPath path: String, size: ImageSize) -> URL {
        var url = baseURL.appendingPathComponent(size.rawValue)
        url = url.appendingPathComponent(path)
        return url
    }

}
