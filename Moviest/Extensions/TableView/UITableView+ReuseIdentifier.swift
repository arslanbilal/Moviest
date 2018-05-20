//
//  UITableView+ReuseIdentifier.swift
//  Moviest
//
//  Created by Bilal Arslan on 19.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

extension UITableViewCell {

    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

}
