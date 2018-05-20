//
//  NibLoadable.swift
//  Moviest
//
//  Created by Bilal Arslan on 19.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var defaultNibName: String { get }
    static func loadFromNib() -> Self
}

extension NibLoadable where Self: UIView {
    
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    static var defaultNib: UINib {
        return UINib(nibName: defaultNibName, bundle: nil)
    }
    
    static func loadFromNib() -> Self {
        guard let nib = Bundle.main.loadNibNamed(defaultNibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("[NibLoadable] Cannot load view from nib.")
        }
        return nib
    }
    
}
