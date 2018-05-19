//
//  LoadingCell.swift
//  Moviest
//
//  Created by Bilal Arslan on 19.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class LoadingCell: BaseTableViewCell, NibLoadable, Instantiatable {

    override func awakeFromNib() {
        selectionStyle = .none
    }

}
