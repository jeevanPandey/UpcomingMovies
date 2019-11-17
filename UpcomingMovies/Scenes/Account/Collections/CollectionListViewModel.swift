//
//  CollectionListViewModel.swift
//  UpcomingMovies
//
//  Created by Alonso on 3/3/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import Foundation
import UpcomingMoviesDomain

final class CollectionListViewModel {
    
    private let useCaseProvider: UseCaseProviderProtocol
    private let collectionOption: ProfileCollectionOption
    private let accountClient = AccountClient()
    private let authManager = AuthenticationManager.shared
    
    var startLoading: Bindable<Bool> = Bindable(false)
    var viewState: Bindable<SimpleViewState<Movie>> = Bindable(.initial)
    
    var movies: [Movie] {
        return viewState.value.currentEntities
    }
    
    var movieCells: [ProfileMovieCellViewModel] {
        return movies.compactMap { ProfileMovieCellViewModel($0) }
    }
    
    let title: String?
    
    // MARK: - Initializers
    
    init(useCaseProvider: UseCaseProviderProtocol, collectionOption: ProfileCollectionOption) {
        self.useCaseProvider = useCaseProvider
        self.collectionOption = collectionOption
        self.title = collectionOption.title
    }
    
    // MARK: - Public
    
    func buildDetailViewModel(atIndex index: Int) -> MovieDetailViewModel? {
        guard index < movies.count else { return nil }
        let movie = movies[index]
        return MovieDetailViewModel(id: movie.id,
                                    title: movie.title,
                                    useCaseProvider: useCaseProvider)
    }
    
    // MARK: - Networking
    
    func getCollectionList() {
        let showLoader = viewState.value.isInitialPage
        fetchCollectionList(page: viewState.value.currentPage, option: collectionOption, showLoader: showLoader)
    }
    
    func refreshCollectionList() {
        fetchCollectionList(page: 1, option: collectionOption, showLoader: false)
    }
    
    func fetchCollectionList(page: Int, option: ProfileCollectionOption, showLoader: Bool) {
        guard let credentials = authManager.userAccount else { return }
        startLoading.value = showLoader
        accountClient.getCollectionList(page: page, option: option,
                                        sessionId: credentials.sessionId,
                                        accountId: credentials.accountId) { result in
            self.startLoading.value = false
            switch result {
            case .success(let movieResult):
                guard let movieResult = movieResult else { return }
                self.processMovieResult(movieResult)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }
    
    private func processMovieResult(_ movieResult: MovieResult) {
        var allMovies = movieResult.currentPage == 1 ? [] : viewState.value.currentEntities
        allMovies.append(contentsOf: movieResult.results)
        guard !allMovies.isEmpty else {
            viewState.value = .empty
            return
        }
        if movieResult.hasMorePages {
            viewState.value = .paging(allMovies, next: movieResult.nextPage)
        } else {
            viewState.value = .populated(allMovies)
        }
    }
    
}
