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
    @IBOutlet weak var recentSearchesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewModelStateChange(change: MovieListState.Change) {
        super.viewModelStateChange(change: change)
        switch change {
        case .moviesChanged(let collectionChange):
            switch collectionChange {
            case .reload:
                if viewModel.state.movies.isEmpty {
                    Alert.present(withTitle: "No movies found!", from: self)
                }
            default:
                break;
            }
        default:
            break;
        }
    }

}

extension SearchViewController {

    override func setupUI() {
        super.setupUI()

        if let searchViewModel = viewModel as? SearchViewModel {
            view.bringSubview(toFront: recentSearchesTableView)
            recentSearchesTableView.dataSource = searchViewModel.recentSearchViewModel
            recentSearchesTableView.delegate = searchViewModel.recentSearchViewModel

            searchViewModel.recentSearchViewModel.selectionHandler = {
                [weak self] query in
                if let model = self?.viewModel as? SearchViewModel {
                    model.searchQuery = query
                }
                self?.searchBar.text = query
                self?.searchBar.resignFirstResponder()
            }
        }
        recentSearchesTableView.register(RecentSearchesCell.defaultNib, forCellReuseIdentifier: RecentSearchesCell.defaultReuseIdentifier)
        recentSearchesTableView.isHidden = true

        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search movies"
        searchBar.tintColor = .red
        navigationItem.titleView = searchBar
        self.searchBar = searchBar
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

extension SearchViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        defer {
            recentSearchesTableView.reloadData()
            recentSearchesTableView.isHidden = false
            searchBar.setShowsCancelButton(true, animated: true)
        }
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        defer {
            recentSearchesTableView.isHidden = true
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
