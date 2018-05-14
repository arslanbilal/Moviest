//
//  BaseNavigationController.swift
//  Moviest
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red]
    }

}
