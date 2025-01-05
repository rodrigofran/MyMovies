import XCTest
@testable import MyMovies

final class MovieListDBWorkerTests: XCTestCase {
    // MARK: - SUT & Mocks
    private func makeSut(dataManagerMock: SwiftDataManagerMock = SwiftDataManagerMock()) -> (MovieListDBWorker, SwiftDataManagerMock) {
        let sut = MovieListDBWorker(dataManager: dataManagerMock)
        return (sut, dataManagerMock)
    }

    // MARK: - Tests
    
    func test_doesFavoriteMovieExist_withExistingMovie_shouldReturnTrue() throws {
        // Given
        let (sut, dataManagerMock) = makeSut()
        let mockFavoriteMovie = FavoriteMovieModel.fixture(id: 1)
        dataManagerMock.favoriteMovies = [mockFavoriteMovie]
        
        // When
        let result = try sut.doesFavoriteMovieExist(id: 1)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func test_doesFavoriteMovieExist_withNonExistingMovie_shouldReturnFalse() throws {
        // Given
        let (sut, dataManagerMock) = makeSut()
        let mockFavoriteMovie = FavoriteMovieModel.fixture(id: 1)
        dataManagerMock.favoriteMovies = [mockFavoriteMovie]
        
        // When
        let result = try sut.doesFavoriteMovieExist(id: 2)
        
        // Then
        XCTAssertFalse(result)
    }

    func test_fetchFavoritesMovies_shouldReturnFavoriteMovies() throws {
        // Given
        let (sut, dataManagerMock) = makeSut()
        let mockFavoriteMovie = FavoriteMovieModel.fixture(id: 1)
        dataManagerMock.favoriteMovies = [mockFavoriteMovie]
        
        // When
        let favoriteMovies = try sut.fetchFavoritesMovies()
        
        // Then
        XCTAssertEqual(favoriteMovies.count, 1)
        XCTAssertEqual(favoriteMovies.first?.id, 1)
        XCTAssertEqual(favoriteMovies.first?.title, "Test Movie")
    }
}
