import XCTest
@testable import MyMovies

final class MovieListPresenterTests: XCTestCase {
    // MARK: - SUT & Mocks
    
    private func makeSut(viewControllerMock: MovieListViewControllerMock = MovieListViewControllerMock()) -> (MovieListPresenter, MovieListViewControllerMock) {
        let sut = MovieListPresenter()
        sut.viewController = viewControllerMock
        return (sut, viewControllerMock)
    }
    
    // MARK: - Tests
    func test_presentMoviesList_shouldCallDisplayMovies() {
        // Given
        let (sut, viewControllerMock) = makeSut()
        let results = [MoviesResult.fixture(id: 1, title: "Movie 1"), MoviesResult.fixture(id: 2, title: "Movie 2")]
        let favoriteIDs: Set<Int> = [1]
        
        let expectation = expectation(description: "waiting presentMoviesList calls displayMovies")
        viewControllerMock.onDisplayCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.presentMoviesList(results: results,
                              loadedImages: [LoadedImage.fixture(), LoadedImage.fixture(movieId: 2)],
                              favoriteMovieIDs: favoriteIDs
        )
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(viewControllerMock.displayMoviesCalled)
            XCTAssertEqual(viewControllerMock.displayMovies?.count, 2)
        }
        
    }
    
    func test_presentMoviesListWithError_shouldCallDisplayMoviesWithError() {
        // Given
        let (sut, viewControllerMock) = makeSut()
        
        let expectation = expectation(description: "waiting presentMoviesList calls displayMovies")
        viewControllerMock.onDisplayCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.presentMoviesListWithError()
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(viewControllerMock.displayMoviesWithErrorCalled)
        }
    }
    
    func test_presentNextMoviesList_shouldCallDisplayNextMovies() {
        // Given
        
        let (sut, viewControllerMock) = makeSut()
        let results = [MoviesResult.fixture(id: 3, title: "Movie 3"), MoviesResult.fixture(id: 4, title: "Movie 4")]
        let favoriteIDs: Set<Int> = [1]
        
        let expectation = expectation(description: "waiting presentNextMoviesList calls displayNextMovies")
        viewControllerMock.onDisplayCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.presentNextMoviesList(
            results: results,
            loadedImages: [LoadedImage.fixture(), LoadedImage.fixture(movieId: 2)],
            favoriteMovieIDs: favoriteIDs
        )
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(viewControllerMock.displayNextMoviesCalled)
            XCTAssertEqual(viewControllerMock.displayNextMovies?.count, 2)
        }
    }
    
    func test_presentNextMoviesListWithError_shouldCallDisplayNextMoviesWithError() {
        // Given
        let (sut, viewControllerMock) = makeSut()
        let expectation = expectation(description: "waiting presentNextMoviesList calls displayNextMoviesWithError")
        
        viewControllerMock.onDisplayCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.presentNextMoviesListWithError()
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(viewControllerMock.displayNextMoviesWithErrorCalled)
        }
    }
    
    func test_presentFavoriteMovieChanged_shouldCallUpdateFavoriteMovieStatus() {
        // Given
        let (sut, viewControllerMock) = makeSut()
        let movieID = 1
        
        let expectation = expectation(description: "waiting presentFavoriteMovieChanged calls UpdateFavoriteMovieStatus")
        
        viewControllerMock.onDisplayCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.presentFavoriteMovieChanged(movieID: movieID)
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(viewControllerMock.updateFavoriteMovieStatusCalled)
            XCTAssertEqual(viewControllerMock.updateFavoriteMovieStatusMovieID, movieID)
        }
    }
}
