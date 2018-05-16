//
//  MovieRequest.swift
//  Moviest
//
//  Created by Bilal Arslan on 16.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation
import Alamofire

private let APIKey = "fc918650eaa758b58bf5cfbfe3178e44"

protocol MovieRequest: BaseRequest { }

extension MovieRequest {

    // Default implementations
    var baseURL: URL                { return URL(string: "https://api.themoviedb.org/3")! }
    var method: HTTPMethod          { return .get }
    var parameters: [String: Any]   { return [:] }
    var headers: [String: String]?  { return nil }
    var encoding: ParameterEncoding { return URLEncoding.default }

    // URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("API URL cannot be resolved! Check API URL and/or path for this request.")
        }

        // Create a api query Item
        let apiKeyItem = URLQueryItem(name: "api_key", value: APIKey)

        // Add APIKey to query Items
        var queryItems = components.queryItems ?? []
        queryItems.append(apiKeyItem)
        components.queryItems = queryItems

        // Check the components for url
        guard let queriedURL = components.url else {
            fatalError("URL cannot be constructed from URL components!")
        }

        do {
            var request = URLRequest(url: queriedURL)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            return try encoding.encode(request, with: parameters)
        } catch {
            // TODO: Error handling
            throw error
        }
    }

}
