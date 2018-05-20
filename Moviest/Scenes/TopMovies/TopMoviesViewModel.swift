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
        state.update(page: Page.default)
        fetch(at: state.page.currentPage) { [weak self] (movies) in
            guard let strongSelf = self else { return }
            strongSelf.onChange?(strongSelf.state.reload(movies: movies))
        }
    }

    func loadMoreMovies() {
        guard state.page.hasNextPage else { return }
        fetch(at: state.page.getNextPage()) { [weak self] (movies) in
            guard let strongSelf = self else { return }
            strongSelf.onChange?(strongSelf.state.insert(movies: movies))
        }
    }

}

extension TopMoviesViewModel {

    func fetch(at page: Int, handler: @escaping ([Movie]) -> Void) {
        onChange?(state.setFetching(fetching: true))
        let request = TopMoviesRequest(page: page)
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
                let page = Page(current: currentPage, total: totalPage)
                strongSelf.state.update(page: page)
                handler(movies)
            case .failure(let error):
                strongSelf.onChange?(.error(.connectionError(error)))
            }
            strongSelf.onChange?(strongSelf.state.setFetching(fetching: false))
        }
    }

}
