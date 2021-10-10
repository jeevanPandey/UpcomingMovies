//
//  MovieDetailMockFactory.swift
//  UpcomingMoviesTests
//
//  Created by Alonso on 8/1/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

@testable import UpcomingMovies
@testable import UpcomingMoviesDomain

class MockMovieDetailInteractor: MovieDetailInteractorProtocol {
    
    var isUserSignedInResult: Bool? = false
    func isUserSignedIn() -> Bool {
        return isUserSignedInResult!
    }
    
    var findGenreResult: Result<Genre?, Error>? = .success(nil)
    func findGenre(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        completion(findGenreResult!)
    }
    
    var getMovieDetailResult: Result<Movie, Error>?
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        completion(getMovieDetailResult!)
    }
    
    var markMovieAsFavoriteResult: Result<Bool, Error>?
    func markMovieAsFavorite(movieId: Int, favorite: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(markMovieAsFavoriteResult!)
    }
    
    var isMovieInFavoritesResult: Result<Bool, Error>?
    func isMovieInFavorites(for movieId: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(isMovieInFavoritesResult!)
    }

    var saveMovieVisitResult: Result<Void, Error>? = .success(Void())
    func saveMovieVisit(with id: Int, title: String, posterPath: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(saveMovieVisitResult!)
    }
    
}

class MockMovieDetailViewFactory: MovieDetailFactoryProtocol {
    
    var options: [MovieDetailOption] = []
    
}
