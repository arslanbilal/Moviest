//
//  SearchViewModel.swift
//  Moviest
//
//  Created by Bilal Arslan on 20.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import UIKit

class SearchViewModel: MovieViewModel {

    fileprivate(set) var state = MovieListState()
    fileprivate(set) var recentSearchViewModel = RecentSearchViewModel()

    var onChange: ((MovieListState.Change) -> Void)?

    var searchQuery: String? {
        didSet {
            _ = state.reload(movies: [])
            reloadMovies()
        }
    }

    func reloadMovies() {
        guard let query = searchQuery else { return }
        state.update(page: Page.default)
        fetchMovies(with: query, page: state.page.currentPage) { [weak self] (movies) in
            guard let strongSelf = self else { return }
            strongSelf.onChange?(strongSelf.state.reload(movies: movies))

            // If query return some movies, add query to last searches list.
            if movies.isEmpty == false {
                strongSelf.recentSearchViewModel.recentSearchesManager.addSearchQuery(query)
            }
        }
    }

    func loadMoreMovies() {
        guard let query = searchQuery else { return }
        guard state.page.hasNextPage else { return }
        fetchMovies(with: query, page: state.page.getNextPage()) { [weak self] (movies) in
            guard let strongSelf = self else { return }
            strongSelf.onChange?(strongSelf.state.insert(movies: movies))
        }
    }

    func clearMovies() {
        searchQuery = nil
        state.update(page: Page.default)
        onChange?(state.reload(movies: []))
    }

}

extension SearchViewModel {

    func fetchMovies(with query: String, page: Int, handler: @escaping ([Movie]) -> Void) {
        onChange?(state.setFetching(fetching: true))
        let request = SearchMoviesRequest(query: query, page: page)
        RequestManager.shared.perform(request) {
            [weak self] (response: Response<MoviesResponse>) in
            guard let strongSelf = self else { return }
            switch response.result {
            case .success(let value):
                guard let movies = value.results,
                    let currentPage = value.page,
                    let totalPage = value.totalPages else {
                        strongSelf.onChange?(.error(.mappingFailed))
                        return
                }
                strongSelf.state.update(page: Page(current: currentPage, total: totalPage))
                handler(movies)
            case .failure(let error):
                strongSelf.onChange?(.error(.connectionError(error)))
            }
            strongSelf.onChange?(strongSelf.state.setFetching(fetching: false))
        }
    }

}
