@testable import MyMovies
import XCTest

// MARK: - SUT & Mocks
final class FavoritesInteractorTests: XCTestCase {
    // MARK: - SUT & Mocks
    
    private func makeSut(
        presenterMock: FavoritesPresenterMock = FavoritesPresenterMock(),
        dbWorkerMock: FavoritesDBWorkerMock = FavoritesDBWorkerMock()
    ) -> (FavoritesInteractor, FavoritesPresenterMock, FavoritesDBWorkerMock) {
        let sut = FavoritesInteractor(presenter: presenterMock, dbWorker: dbWorkerMock)
        return (sut, presenterMock, dbWorkerMock)
    }
    
    // MARK: - Tests
    
    func test_viewWillAppear_shouldFetchFavoritesAndCallPresentFavoritesMovies() {
        // Given
        let (sut, presenterMock, dbWorkerMock) = makeSut()
        let favoriteMovies = [
            FavoriteMovieModel.fixture(id: 1, title: "Movie 1"),
            FavoriteMovieModel.fixture(id: 2, title: "Movie 2")
        ]
        dbWorkerMock.favoriteMoviesToReturn = favoriteMovies
        
        // When
        sut.viewWillAppear()
        
        // Then
        XCTAssertTrue(dbWorkerMock.fetchFavoritesMoviesCalled)
        XCTAssertTrue(presenterMock.presentFavoritesMoviesCalled)
        XCTAssertEqual(presenterMock.receivedFavoritesMovies, favoriteMovies)
    }
    
    func test_viewWillAppear_shouldCallPresentErrorDbOnFetchFailure() {
        // Given
        let (sut, presenterMock, dbWorkerMock) = makeSut()
        dbWorkerMock.fetchFavoritesMoviesError = NSError(domain: "TestError", code: 1)
        
        // When
        sut.viewWillAppear()
        
        // Then
        XCTAssertTrue(dbWorkerMock.fetchFavoritesMoviesCalled)
        XCTAssertTrue(presenterMock.presentErrorDbCalled)
    }
    
    func test_removeFavoriteMovie_shouldRemoveMovieAndCallPresentRemovedFavoriteMovie() {
        // Given
        let (sut, presenterMock, dbWorkerMock) = makeSut()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.removeFavoriteMovie(id: 1, indexPath: indexPath)
        
        // Then
        XCTAssertTrue(dbWorkerMock.removeFavoriteMovieCalled)
        XCTAssertTrue(presenterMock.presentRemovedFavoriteMovieCalled)
        XCTAssertEqual(presenterMock.receivedIndexPath, indexPath)
    }
    
    func test_removeFavoriteMovie_shouldCallPresentErrorDbOnRemoveFailure() {
        // Given
        let (sut, presenterMock, dbWorkerMock) = makeSut()
        dbWorkerMock.removeFavoriteMovieError = NSError(domain: "TestError", code: 2)
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.removeFavoriteMovie(id: 1, indexPath: indexPath)
        
        // Then
        XCTAssertTrue(dbWorkerMock.removeFavoriteMovieCalled, "removeFavoriteMovie should be called")
        XCTAssertTrue(presenterMock.presentErrorDbCalled, "presentErrorDb should be called when remove fails")
    }
}
