//
//  Requestable.swift
//  Moviest
//
//  Created by Bilal Arslan on 15.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation
import Alamofire


private let APIKey                      = "fc918650eaa758b58bf5cfbfe3178e44"
typealias Completion<T: Codable> = (_ responseObject: Response<T>) -> Void
typealias NetworkManagerRequest  = DataRequest

public protocol MovieRequest: URLRequestConvertible {

    // The target's base `URL`.
    var baseURL: URL { get }

    // The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    // The HTTP method used in the request.
    var method: HTTPMethod { get }

    // The HTTP parameters used in the request.
    var parameters: Parameters { get }

    // The HTTP parameters encoding format used in the request
    var encoding: ParameterEncoding { get }

    // The headers to be used in the request.
    var headers: [String: String]? { get }

}

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

protocol Requestable {

    @discardableResult func request<T: JSONCodable>(_ request: MovieRequest, handleCompletion: @escaping Completion<T>) -> NetworkManagerRequest?

}
