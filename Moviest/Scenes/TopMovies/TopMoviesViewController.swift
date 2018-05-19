//
//  TopMoviesViewController.swift
//  Moviest
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class TopMoviesViewController: BaseViewController {

    // MARK: IBActions
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    var viewModel: TopMoviesViewModel = TopMoviesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        reloadMovies()
    }

    func viewModelStateChange(change: MovieListState.Change) {
        switch change {
        case .none:
            break
        case .fetchStateChanged:
            if viewModel.state.fetching {
                // TODO:  Show loading
            } else {
                // TODO: Dismiss loading
            }
            break
        case .moviesChanged(let collectionChange):
            switch collectionChange {
            case .reload:
                // Reload table view by applying collection change
                tableView.applyCollectionChange(collectionChange, toSection: 0, withAnimation: .fade)

//                if model.state.movies.isEmpty {
//                    // TODO: Present empty state
//                } else {
//                    // TODO: Dismiss empty state
//                }
//                // Stop refresh control
//                refreshControl?.endRefreshing()
            default:
                tableView.beginUpdates()
                if !viewModel.state.page.hasNextPage {
                    tableView.applyCollectionChange(CollectionChange.deletion(0), toSection: 0, withAnimation: .fade)
                }
                tableView.applyCollectionChange(collectionChange, toSection: 0, withAnimation: .fade)
                tableView.endUpdates()
            }
            break
        case .error(/*let movieError*/_):
            // State of the view
            break
        }
    }

}

// MARK: View Setup

extension TopMoviesViewController {

    func setupTableView() {
        tableView.register(MovieRowCell.defaultNib, forCellReuseIdentifier: MovieRowCell.defaultReuseIdentifier)
    }

    func bindViewModel() {
        viewModel.onChange = viewModelStateChange
    }

    func reloadMovies() {
        viewModel.reloadMovies()
    }
}

// MARK: UITableViewDataSource

extension TopMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieRowCell.defaultReuseIdentifier, for: indexPath) as? MovieRowCell else {
            return UITableViewCell()
        }
        let movie = viewModel.state.movies[indexPath.row]
        movieCell.viewBindableModel = movie
        return movieCell
    }

}
