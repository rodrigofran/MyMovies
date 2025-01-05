import XCTest
@testable import MyMovies

final class MovieDetailDBWorkerTests: XCTestCase {
    
    // MARK: - SUT & Dummies
    private func makeSut() -> (MovieDetailDBWorker, SwiftDataManagerMock) {
        let dataManagerMock = SwiftDataManagerMock()
        let dbWorker = MovieDetailDBWorker(dataManager: dataManagerMock)
        return (dbWorker, dataManagerMock)
    }
    
    let movie = FavoriteMovieModel.fixture()
    
    // MARK: - Tests
    
    func test_doesFavoriteMovieExist_shouldReturnTrueIfMovieExists() throws {
        // Given
        let (sut, dataManagerMock) = makeSut()
        try dataManagerMock.saveFavoriteMovie(movie)
        
        // When
        let result = try sut.doesFavoriteMovieExist(id: 1)
        
        // Then
        XCTAssertTrue(dataManagerMock.favoriteMovies.contains(where: { $0.id == 1 }))
        XCTAssertTrue(result)
    }
    
    func test_doesFavoriteMovieExist_shouldReturnFalseIfMovieDoesNotExist() throws {
        // Given
        let (sut, _) = makeSut()
        
        // When
        let result = try sut.doesFavoriteMovieExist(id: 1)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_saveFavoriteMovie_shouldCallSaveMovieAndStoreMovie() throws {
        // Given
        let (sut, dataManagerMock) = makeSut()
        
        // When
        try sut.saveFavoriteMovie(movie)
        
        // Then
        XCTAssertTrue(dataManagerMock.didSaveMovie)
        XCTAssertTrue(dataManagerMock.favoriteMovies.contains { $0.id == 1 })
    }
    
    func test_removeFavoriteMovie_shouldCallRemoveMovieAndDeleteMovie() throws {
        // Given
        let (sut, dataManagerMock) = makeSut()
        try dataManagerMock.saveFavoriteMovie(movie)
        
        // When
        try sut.removeFavoriteMovie(id: 1)
        
        // Then
        XCTAssertTrue(dataManagerMock.didRemoveMovie)
        XCTAssertFalse(dataManagerMock.favoriteMovies.contains { $0.id == 1 })
    }
    
    func test_saveFavoriteMovie_shouldThrowErrorIfSaveFails() throws {
        // Given
        let (sut, dataManagerMock) = makeSut()
        dataManagerMock.error = NSError(domain: "Database", code: 500, userInfo: nil)
        
        // When / Then
        XCTAssertThrowsError(try sut.saveFavoriteMovie(movie)) { error in
            XCTAssertEqual((error as NSError).domain, "Database")
            XCTAssertEqual((error as NSError).code, 500)
        }
    }
    
    func test_removeFavoriteMovie_shouldThrowErrorIfRemoveFails() throws {
        // Given
        let (sut, dataManagerMock) = makeSut()
        dataManagerMock.error = NSError(domain: "Database", code: 500, userInfo: nil)
        
        // When / Then
        XCTAssertThrowsError(try sut.removeFavoriteMovie(id: 1)) { error in
            XCTAssertEqual((error as NSError).domain, "Database")
            XCTAssertEqual((error as NSError).code, 500)
        }
    }
}
