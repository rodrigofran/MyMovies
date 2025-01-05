import XCTest
@testable import MyMovies

final class FavoritesDBWorkerTests: XCTestCase {
    
    // MARK: - SUT & Mocks
    private func makeSut(fetchFavoritesMoviesError: Error? = nil, removeFavoriteMovieError: Error? = nil) -> FavoritesDBWorkerMock {
        let sut = FavoritesDBWorkerMock()
        sut.fetchFavoritesMoviesError = fetchFavoritesMoviesError
        sut.removeFavoriteMovieError = removeFavoriteMovieError
        return sut
    }
    
    // MARK: - Tests
    
    func test_fetchFavoritesMovies_shouldCallFetchFavoritesMovies() {
        // Given
        let sut = makeSut()
        
        // When
        do {
            _ = try sut.fetchFavoritesMovies()
        } catch {
            XCTFail("Error should not be thrown")
        }
        
        // Then
        XCTAssertTrue(sut.fetchFavoritesMoviesCalled)
    }
    
    func test_fetchFavoritesMovies_shouldReturnFavoriteMovies() {
        // Given
        let expectedMovies = [FavoriteMovieModel.fixture(id: 1), FavoriteMovieModel.fixture(id: 2)]
        let sut = makeSut()
        sut.favoriteMoviesToReturn = expectedMovies
        
        // When
        var returnedMovies: [FavoriteMovieModel] = []
        do {
            returnedMovies = try sut.fetchFavoritesMovies()
        } catch {
            XCTFail("Error should not be thrown")
        }
        
        // Then
        XCTAssertEqual(returnedMovies.count, expectedMovies.count, "The number of returned movies should match")
    }
    
    func test_removeFavoriteMovie_shouldHandleError() {
            // Given
            let expectedError = NSError(domain: "com.moviechallenge.error", code: 1, userInfo: nil)
            let sut = makeSut(removeFavoriteMovieError: expectedError)
            
            // When
            do {
                try sut.removeFavoriteMovie(id: 1)
                XCTFail("Error should be thrown")
            } catch let error as NSError {
                // Then
                XCTAssertEqual(error, expectedError)
            }
        }
    }
