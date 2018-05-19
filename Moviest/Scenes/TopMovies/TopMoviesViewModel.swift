//
//  TopMoviesViewModel.swift
//  Moviest
//
//  Created by Bilal Arslan on 19.05.2018.
//  Copyright © 2018 Bilal Arslan. All rights reserved.
//

import Foundation

class TopMoviesViewModel: MovieViewModel {

    fileprivate(set) var state = MovieListState()
    var onChange: ((MovieListState.Change) -> Void)?

    func reloadMovies() {
        state.update(page: Page(current: 1, total: 1))
        fetch(at: state.page.currentPage)
    }

    func loadMoreMovies() {
        guard state.page.hasNextPage else { return }
        fetch(at: state.page.getNextPage())
    }

}

extension TopMoviesViewModel {

    func fetch(at page: Int) {
        onChange?(state.setFetching(fetching: true))
        let request = TopMoviesRequest(page: page)
        RequestManager.shared.perform(request) { [weak self] (response: Response<MoviesResponse>) in
            guard let strongSelf = self else {
                return
            }
            switch response.result {
            case .success(let value):
                guard let movies = value.results,
                    let currentPage = value.page,
                    let totalPage = value.totalPages else {
                        strongSelf.onChange?(.error(.mappingFailed))
                        return
                }
                strongSelf.state.update(page: Page(current: currentPage, total: totalPage))
                if strongSelf.state.movies.count > 0 {
                    strongSelf.onChange?(strongSelf.state.insert(movies: movies))
                } else {
                    strongSelf.onChange?(strongSelf.state.reload(movies: movies))
                }
            case .failure(let error):
                strongSelf.onChange?(.error(.connectionError(error)))
            }
            strongSelf.onChange?(strongSelf.state.setFetching(fetching: false))
        }
    }

}
