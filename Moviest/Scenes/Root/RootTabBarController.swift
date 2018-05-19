//
//  RootTabBarController.swift
//  Moviest
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName: String = Constants.StoryboardName.root

    override func viewDidLoad() {
        super.viewDidLoad()
        initWithCustom()
    }

    func initWithCustom() {
        let topMoviesViewController = TopMoviesViewController.instantiate()
        topMoviesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        topMoviesViewController.viewModel = TopMoviesViewModel()
        let topMoviesNavigationController = BaseNavigationController(rootViewController: topMoviesViewController)

        viewControllers = [topMoviesNavigationController]
    }

}
