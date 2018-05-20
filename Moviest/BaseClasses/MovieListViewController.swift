//
//  MovieListViewController.swift
//  Moviest
//
//  Created by Bilal Arslan on 20.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class MovieListViewController: BaseViewController {

    fileprivate enum C {
        static let contentCellHeight: CGFloat = 240.0
        static let loadingCellHeight: CGFloat = 80.0
    }

    @IBOutlet fileprivate weak var tableView: UITableView!

    var viewModel: MovieViewModel!
    var loadingView = LoadingView.instantiate()
    var emptyStateView = EmptyView.instantiate()
    weak var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        reloadMovies()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadingView.center = view.center
    }

    func viewModelStateChange(change: MovieListState.Change) {
        switch change {
        case .none:
            break
        case .fetchStateChanged:
            loadingView.isHidden = !viewModel.state.fetching
            break
        case .moviesChanged(let collectionChange):
            switch collectionChange {
            case .reload:
                // Reload table view by applying collection change
                tableView.applyCollectionChange(collectionChange,
                                                toSection: PaginationSection.content.rawValue,
                                                withAnimation: .fade)
            default:
                tableView.beginUpdates()
                if !viewModel.state.page.hasNextPage {
                    tableView.applyCollectionChange(CollectionChange.deletion(0),
                                                    toSection: PaginationSection.content.rawValue,
                                                    withAnimation: .fade)
                }
                tableView.applyCollectionChange(collectionChange,
                                                toSection: PaginationSection.content.rawValue,
                                                withAnimation: .fade)
                tableView.endUpdates()
            }
            emptyStateView.isHidden = !viewModel.state.movies.isEmpty
            break
        case .error(let movieError):
            switch movieError {
            case .connectionError(_):
                Alert.present(withTitle: "Connection Error", description: "Check your network status and pull to refresh", from: self)
            case .mappingFailed:
                Alert.present(withTitle: "Invalid Data", description: "There is an error when getting data from server. Please pull to refresh", from: self)
            case .reloadFailed:
                Alert.present(withTitle: "Invalid Data", description: "There is an error when getting data from server. Please pull to refresh", from: self)
            }
            break
        }
        refreshControl?.endRefreshing()
    }

}

// MARK: View Setup

extension MovieListViewController {

    // @objc for overriding functions

    @objc func setupUI() {
        tableView.register(MovieRowCell.defaultNib, forCellReuseIdentifier: MovieRowCell.defaultReuseIdentifier)
        tableView.register(LoadingCell.defaultNib, forCellReuseIdentifier: LoadingCell.defaultReuseIdentifier)

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        refreshControl.attributedTitle =
            NSAttributedString(string: "Pull To Refresh",
                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.red,
                                            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
        refreshControl.addTarget(self, action: #selector(reloadMovies), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateView)
        view.bringSubview(toFront: emptyStateView)
        emptyStateView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyStateView.isHidden = true

        view.addSubview(loadingView)
        view.bringSubview(toFront: loadingView)
        loadingView.center = view.center
        loadingView.isHidden = true

        self.refreshControl = refreshControl
    }

    func bindViewModel() {
        viewModel.onChange = viewModelStateChange
    }

    @objc func reloadMovies() {
        viewModel.reloadMovies()
    }

}

// MARK: UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return PaginationSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = PaginationSection(rawValue: section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return viewModel.state.movies.count
        case .loading:
            return viewModel.state.page.hasNextPage ? 1 : 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieRowCell.defaultReuseIdentifier, for: indexPath) as? MovieRowCell else {
                fatalError("Invalid cell Identifier! Check `MovieRowCell` identifier function.")
            }
            let movie = viewModel.state.movies[indexPath.row]
            movieCell.viewBindableModel = movie
            return movieCell
        case .loading:
            return tableView.dequeueReusableCell(withIdentifier: LoadingCell.defaultReuseIdentifier,
                                                 for: indexPath)
        }
    }

}

// MARK: UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        if section == .content {
            if viewModel.state.page.hasNextPage,
                indexPath.row == (viewModel.state.movies.count - PaginationSection.offset) {
                viewModel.loadMoreMovies()
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return UITableViewAutomaticDimension
        case .loading:
            return C.loadingCellHeight
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = PaginationSection(rawValue: indexPath.section) else {
            fatalError("Invalid section! Check `numberOfSections` function.")
        }
        switch section {
        case .content:
            return C.contentCellHeight
        case .loading:
            return C.loadingCellHeight
        }
    }

}
