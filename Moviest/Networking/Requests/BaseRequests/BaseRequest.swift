//
//  BaseRequest.swift
//  Moviest
//
//  Created by Bilal Arslan on 16.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation
import Alamofire

public protocol BaseRequest: URLRequestConvertible {

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
