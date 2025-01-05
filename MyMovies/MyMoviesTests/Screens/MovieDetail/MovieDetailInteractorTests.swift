import XCTest
@testable import MyMovies

final class MovieDetailInteractorTests: XCTestCase {
    
    // MARK: - SUT & Dummies
    private func makeSut() -> (MovieDetailInteractor, MovieDetailPresenterMock, MovieDetailAPIWorkerMock, MovieDetailDBWorkerMock) {
        let presenterMock = MovieDetailPresenterMock()
        let apiWorkerMock = MovieDetailAPIWorkerMock()
        let dbWorkerMock = MovieDetailDBWorkerMock()
        let sut = MovieDetailInteractor(presenter: presenterMock, apiWorker: apiWorkerMock, dbWorker: dbWorkerMock)
        return (sut, presenterMock, apiWorkerMock, dbWorkerMock)
    }
    
    // MARK: - Tests
    
    func test_viewDidLoad_shouldFetchGenres() {
        // Given
        let (sut, presenterMock, apiWorkerMock, _) = makeSut()
        let expectation = expectation(description: "waiting presenter call presentAllGenres")
        
        presenterMock.onPresentCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(apiWorkerMock.fetchGenresCalled)
            XCTAssertTrue(presenterMock.presentAllGenresCalled)
        }
    }
    
    func test_addOrRemoveFavorites_shouldAddFavorite() {
        // Given
        let (sut, presenterMock, _, dbWorkerMock) = makeSut()
        let movie = LoadedResult.fixture()
        dbWorkerMock.doesFavoriteMovieExistResult = false
        
        // When
        sut.addOrRemoveFavorites(movie: movie, id: movie.id ?? 0)
        
        // Then
        XCTAssertTrue(dbWorkerMock.saveFavoriteMovieCalled)
        XCTAssertTrue(presenterMock.presentSavedFavoriteMovieCalled)
    }
    
    func test_addOrRemoveFavorites_shouldRemoveFavorite() {
        // Given
        let (sut, presenter, _, dbWorker) = makeSut()
        let movie = LoadedResult.fixture()
        dbWorker.doesFavoriteMovieExistResult = true
        
        // When
        sut.addOrRemoveFavorites(movie: movie, id: movie.id ?? 0)
        
        // Then
        XCTAssertTrue(dbWorker.removeFavoriteMovieCalled)
        XCTAssertTrue(presenter.presentRemovedFavoriteMovieCalled)
    }
    
    func test_addOrRemoveFavorites_shouldHandleError() {
        // Given
        let (sut, presenter, _, dbWorker) = makeSut()
        let movie = LoadedResult.fixture()
        dbWorker.doesFavoriteMovieExistError = NSError(domain: "Test", code: 1, userInfo: nil)
        
        // When
        sut.addOrRemoveFavorites(movie: movie, id: movie.id ?? 0)
        
        // Then
        XCTAssertTrue(presenter.presentErrorDbCalled)
    }
}
