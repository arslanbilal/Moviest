//
//  Instantiatable.swift
//  Moviest
//
//  Created by Bilal Arslan on 19.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

protocol Instantiatable {
    static func instantiate() -> Self
}

extension Instantiatable where Self: NibLoadable {
    static func instantiate() -> Self {
        return loadFromNib()
    }
}

extension Instantiatable where Self: StoryboardLoadable {
    static func instantiate() -> Self {
        return loadFromStoryboard()
    }
}
