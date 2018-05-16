//
//  Requestable.swift
//  Moviest
//
//  Created by Bilal Arslan on 15.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation
import Alamofire

typealias Completion<T: Codable>    = (_ responseObject: Response<T>) -> Void
typealias NetworkManagerRequest     = DataRequest

protocol Requestable {

    @discardableResult func request<T: JSONCodable>(_ request: MovieRequest, handleCompletion: @escaping Completion<T>) -> NetworkManagerRequest?

}
