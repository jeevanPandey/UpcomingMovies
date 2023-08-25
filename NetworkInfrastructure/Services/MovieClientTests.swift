//
//  MovieClientTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 21/08/23.
//

import XCTest
@testable import NetworkInfrastructure

final class MovieClientTests: XCTestCase {

    private var urlSession: MockURLSession!
    private var movieClient: MovieClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        urlSession = MockURLSession()
        movieClient = MovieClient(session: urlSession)

    }

    override func tearDownWithError() throws {
        urlSession = nil
        movieClient = nil
        try super.tearDownWithError()
    }

    func testGetPopularMoviesSuccess() throws {
        // Arrange
        let data = try JSONEncoder().encode(MovieResult(results: [], currentPage: 1, totalPages: 1))
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get popular movies success")
        // Act
        movieClient.getPopularMovies(page: 1) { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get popular movies error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetPopularMoviesError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get popular movies error")
        // Act
        movieClient.getPopularMovies(page: 1) { result in
            switch result {
            case .success:
                XCTFail("Get popular movies success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

}