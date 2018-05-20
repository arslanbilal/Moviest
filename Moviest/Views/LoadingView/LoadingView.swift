//
//  LoadingView.swift
//  Moviest
//
//  Created by Bilal Arslan on 20.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class LoadingView: UIView, NibLoadable, Instantiatable {

    override func awakeFromNib() {
        layer.cornerRadius = 5
    }

}
