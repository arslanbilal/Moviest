//
//  SearchViewController.swift
//  Moviest
//
//  Created by Bilal Arslan on 14.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class SearchViewController: MovieListViewController, StoryboardLoadable, Instantiatable {

    static var defaultStoryboardName: String = Constants.StoryboardName.search

    fileprivate weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func reloadMovies() {
        super.reloadMovies()
        guard let vm = viewModel as? SearchViewModel,
            let refreshControl = refreshControl else {
                return
        }
        if vm.searchQuery == nil, refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

}

extension SearchViewController {

    override func setupUI() {
        super.setupUI()
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search movies"
        searchBar.tintColor = .red
        navigationItem.titleView = searchBar
        self.searchBar = searchBar
    }

}

extension SearchViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        defer {
            searchBar.setShowsCancelButton(true, animated: true)
        }
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        defer {
            searchBar.setShowsCancelButton(false, animated: true)
        }
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let model = viewModel as? SearchViewModel,
        let query = searchBar.text, !query.isEmpty else { return }
        model.searchQuery = query
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text?.isEmpty == true {
            (viewModel as? SearchViewModel)?.clearMovies()
        }
    }

}
