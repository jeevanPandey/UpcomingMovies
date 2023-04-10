//
//  GenreRepository.swift
//  UpcomingMoviesData
//
//  Created by Alonso on 11/2/19.
//  Copyright © 2019 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

public final class GenreRepository: GenreUseCaseProtocol {

    private let localDataSource: GenreLocalDataSourceProtocol
    private let remoteDataSource: GenreRemoteDataSourceProtocol

    init(localDataSource: GenreLocalDataSourceProtocol,
         remoteDataSource: GenreRemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    public var didUpdateGenre: (() -> Void)? {
        didSet {
            self.localDataSource.didUpdateGenre = didUpdateGenre
        }
    }

    public func find(with id: Int, completion: @escaping (Result<Genre?, Error>) -> Void) {
        completion(.success(localDataSource.find(with: id)))
    }

    // TODO: - Adds forceRefresh parameter
    public func fetchAll(completion: @escaping (Result<[Genre], Error>) -> Void) {
        let localGenres = localDataSource.findAll()
        if !localGenres.isEmpty { completion(.success(localGenres)) }

        remoteDataSource.getAllGenres(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let remoteGenres):
                self.localDataSource.saveGenres(remoteGenres)
                if localGenres.isEmpty { completion(.success(remoteGenres)) }
            case .failure(let error):
                if localGenres.isEmpty { completion(.failure(error)) }
            }
        })
    }

}
