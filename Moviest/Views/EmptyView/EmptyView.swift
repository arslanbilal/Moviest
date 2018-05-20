//
//  EmptyView.swift
//  Moviest
//
//  Created by Bilal Arslan on 20.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class EmptyView: UIView, NibLoadable, Instantiatable {

    @IBOutlet private weak var emptyStateLabel: UILabel!

    func updateLabel(string: String) {
        if !string.isEmpty {
            emptyStateLabel.text = string
        }
    }

}
