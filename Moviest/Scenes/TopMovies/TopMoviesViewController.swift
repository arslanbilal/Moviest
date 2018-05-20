//
//  TopMoviesViewController.swift
//  Moviest
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class TopMoviesViewController: MovieListViewController, StoryboardLoadable, Instantiatable {

    static var defaultStoryboardName: String = Constants.StoryboardName.topMovies

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Rated"
    }

}
