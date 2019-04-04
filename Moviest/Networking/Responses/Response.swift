//
//  Response.swift
//  Moviest
//
//  Created by Bilal Arslan on 15.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation
import Alamofire

struct Response<Value: Codable> {

    var request: URLRequest?
    var response: HTTPURLResponse?
    var data: Data?
    var result: Result<Value, NetworkError>

}
