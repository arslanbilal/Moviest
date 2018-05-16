//
//  DateFormatter+CustomFormatter.swift
//  Moviest
//
//  Created by Bilal Arslan on 16.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

extension DateFormatter {

    static private let customDateFormatter = DateFormatter()

    static func string(from date: Date, format: String) -> String {
        customDateFormatter.dateFormat = format
        return customDateFormatter.string(from: date)
    }

    static func date(from string: String, format: String) -> Date? {
        customDateFormatter.dateFormat = format
        return customDateFormatter.date(from: string)
    }

}
