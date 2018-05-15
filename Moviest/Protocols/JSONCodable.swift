//
//  JSONCodable.swift
//  Moviest
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

protocol JSONCodable { }

extension JSONCodable where Self: Codable {

    static var encoder: JSONEncoder { return JSONEncoder() }
    static var decoder: JSONDecoder { return JSONDecoder() }

    // Return instances as JSON Data.
    func jsonData() -> Data? {
        return try? Self.encoder.encode(self)
    }

    // Create instances of our type from JSON Data.
    init?(jsonData: Data?) {
        guard let data = jsonData,
            let anInstance = try? Self.decoder.decode(Self.self, from: data)
            else { return nil }
        self = anInstance
    }

}
