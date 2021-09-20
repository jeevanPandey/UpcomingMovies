//
//  MovieCreditsTests.swift
//  NetworkInfrastructure
//
//  Created by Alonso on 19/09/21.
//

import XCTest
@testable import NetworkInfrastructure

class MovieCreditsTests: XCTestCase {

    // MARK: - Cast tests

    func testMissingIdFromCastResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Cast.self, from: jsonDataToTest))
    }

    func testMissingCharacterFromCastResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "character")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Cast.self, from: jsonDataToTest))
    }

    func testMissingNameFromCastResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "name")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Cast.self, from: jsonDataToTest))
    }

    func testIdFromCastResponse() throws {
        // Arrange
        let idToTest = 123456
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("id", idToTest))
        let decodedCast = try JSONDecoder().decode(Cast.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedCast.id, idToTest)
    }

    func testCharacterFromCastResponse() throws {
        // Arrange
        let idToTest = "castId"
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("character", idToTest))
        let decodedCast = try JSONDecoder().decode(Cast.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedCast.character, idToTest)
    }

    func testNameFromCastResponse() throws {
        // Arrange
        let idToTest = "name"
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(updatingKeyPaths: ("name", idToTest))
        let decodedCast = try JSONDecoder().decode(Cast.self, from: jsonDataToTest)
        // Assert
        XCTAssertEqual(decodedCast.name, idToTest)
    }

    // MARK: - Crew tests

    func testMissingIdFromCrewResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "id")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Crew.self, from: jsonDataToTest))
    }

    func testMissingJobFromCrewResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "job")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Crew.self, from: jsonDataToTest))
    }

    func testMissingNameFromCrewResponse() throws {
        // Arrange
        let dataResponse = MockResponse.cast.dataResponse
        // Act
        let jsonDataToTest = try dataResponse.json(deletingKeyPaths: "name")
        // Assert
        XCTAssertThrowsError(try JSONDecoder().decode(Crew.self, from: jsonDataToTest))
    }

}
