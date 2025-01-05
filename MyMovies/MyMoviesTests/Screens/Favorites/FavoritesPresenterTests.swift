import XCTest
@testable import MyMovies

// MARK: - SUT & Mocks
final class FavoritesPresenterTests: XCTestCase {
    // MARK: - SUT & Mocks
    
    private func makeSut(
        viewControllerMock: FavoritesViewControllerMock = FavoritesViewControllerMock()
    ) -> (FavoritesPresenter, FavoritesViewControllerMock) {
        let sut = FavoritesPresenter()
        sut.viewController = viewControllerMock
        return (sut, viewControllerMock)
    }
    
    // MARK: - Tests
    
    func test_presentFavoritesMovies_shouldCallDisplayFavoritesMovies() {
        // Given
        let (sut, viewControllerMock) = makeSut()
        let favoriteMoviesStub = [
            FavoriteMovieModel.fixture(id: 1, title: "Movie 1"),
            FavoriteMovieModel.fixture(id: 2, title: "Movie 2")
        ]
        
        // When
        sut.presentFavoritesMovies(favoritesMovies: favoriteMoviesStub)
        
        // Then
        XCTAssertTrue(viewControllerMock.displayFavoritesMoviesCalled, "displayFavoritesMovies should be called")
        XCTAssertEqual(viewControllerMock.receivedFavoriteMovies, favoriteMoviesStub, "ViewController should receive the correct favorite movies")
    }
    
    func test_presentRemovedFavoriteMovie_shouldCallDisplayRemovedFavoriteMovie() {
        // Given
        let (sut, viewControllerMock) = makeSut()
        let indexPath = IndexPath(row: 0, section: 0)
        let expectedMessage = "Movie removed from favorites"
        
        // When
        sut.presentRemovedFavoriteMovie(indexPath: indexPath)
        
        // Then
        XCTAssertTrue(viewControllerMock.displayRemovedFavoriteMovieCalled, "displayRemovedFavoriteMovie should be called")
        XCTAssertEqual(viewControllerMock.receivedIndexPath, indexPath, "ViewController should receive the correct indexPath")
        XCTAssertEqual(viewControllerMock.receivedErrorMessage, expectedMessage, "ViewController should receive the correct message")
    }
    
    func test_presentErrorDb_shouldCallDisplayErrorDatabase() {
        // Given
        let (sut, viewControllerMock) = makeSut()
        let expectedMessage = "Unable to remove movie from favorites"
        
        // When
        sut.presentErrorDb()
        
        // Then
        XCTAssertTrue(viewControllerMock.displayErrorDatabaseCalled, "displayErrorDatabase should be called")
        XCTAssertEqual(viewControllerMock.receivedErrorMessage, expectedMessage, "ViewController should receive the correct error message")
    }
}
