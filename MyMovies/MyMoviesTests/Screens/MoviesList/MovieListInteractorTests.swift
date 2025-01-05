import XCTest
@testable import MyMovies

final class MoviesListInteractorTests: XCTestCase {
    // MARK: - SUT & Mocks
    
    private func makeSut(
        presenterMock: MovieListPresenterMock = MovieListPresenterMock(),
        apiWorkerMock: MovieListAPIWorkerMock = MovieListAPIWorkerMock(),
        dbWorkerMock: MovieListDBWorkerMock = MovieListDBWorkerMock()
    ) -> (MoviesListInteractor, MovieListPresenterMock, MovieListAPIWorkerMock, MovieListDBWorkerMock) {
        let sut = MoviesListInteractor(
            presenter: presenterMock,
            apiWorker: apiWorkerMock,
            dbWorker: dbWorkerMock
        )
        return (sut, presenterMock, apiWorkerMock, dbWorkerMock)
    }

// MARK: - Tests
    func test_viewWillAppear_shouldCallPresentMoviesList() {
        // Given
        let (sut, presenterMock, apiWorkerMock, dbWorkerMock) = makeSut()
        let mockMovie = Movie.fixture(page: 1, results: [MoviesResult.fixture(id: 1, title: "Test Movie")])
        apiWorkerMock.fetchMoviesToReturn = mockMovie
        dbWorkerMock.favoriteMoviesToReturn = [FavoriteMovieModel.fixture(id: 1, title: "Test Movie")]

        let expectation = expectation(description: "waiting presenter calls presentMoviesList")

        presenterMock.onPresentCalled = {
            expectation.fulfill()
        }

        // When
        sut.viewDidLoad(isFirstFetch: true)

        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(presenterMock.presentMoviesListCalled)
            XCTAssertEqual(presenterMock.presentMoviesListMovies?.count, 1)
            XCTAssertEqual(presenterMock.presentMoviesListMovies?.first?.title, "Test Movie")
            XCTAssertTrue(apiWorkerMock.fetchMoviesCalled)
            XCTAssertTrue(dbWorkerMock.fetchFavoritesMoviesCalled)
        }
    }
    
    func test_viewWillAppear_shouldCallPresentMoviesListWithError() {
        // Given
        
        let (sut, presenterMock, apiWorkerMock, _) = makeSut()
        
        apiWorkerMock.fetchMoviesCalled = false
        
        let expectation = self.expectation(description: "waiting viewWillAppear calls to presentMoviesListWithError")
        
        presenterMock.onPresentCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.viewDidLoad(isFirstFetch: true)
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(presenterMock.presentMoviesListWithErrorCalled)
        }
    }
    
    func test_viewWillAppear_shouldCallPresentNextMoviesList() {
        // Given
        let (sut, presenterMock, apiWorkerMock, dbWorkerMock) = makeSut()
        let mockMovie = Movie.fixture(page: 2, results: [MoviesResult.fixture(id: 2, title: "Test Movie 2"), MoviesResult.fixture(id: 3, title: "Test Movie 3")])
        apiWorkerMock.fetchMoviesToReturn = mockMovie
        dbWorkerMock.favoriteMoviesToReturn = [FavoriteMovieModel.fixture(id: 2, title: "Test Movie 2")]

        let expectation = expectation(description: "waiting presenter calls presentNextMoviesList")

        presenterMock.onPresentCalled = {
            expectation.fulfill()
        }

        // When
        sut.viewDidLoad(isFirstFetch: false)

        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(presenterMock.presentNextMoviesListCalled)
            XCTAssertEqual(presenterMock.presentNextMoviesListMovies?.count, 2)
            XCTAssertEqual(presenterMock.presentNextMoviesListMovies?.first?.title, "Test Movie 2")
            XCTAssertTrue(apiWorkerMock.fetchMoviesCalled)
            XCTAssertTrue(dbWorkerMock.fetchFavoritesMoviesCalled)
        }
    }
    
    func test_viewWillAppear_shouldCallPresentNextMoviesListWithError() {
        // Given
        let (sut, presenterMock, apiWorkerMock, _) = makeSut()
        
        apiWorkerMock.fetchMoviesCalled = false
        
        let expectation = expectation(description: "waiting presenter calls presentNextMoviesListWithError")

        presenterMock.onPresentCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.viewDidLoad(isFirstFetch: false)
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(presenterMock.presentNextMoviesListWithErrorCalled)
        }
    }
    
    func test_handleFavoriteMovieChanged_shouldCallPresentFavoriteMovieChanged() {
        // Given
        let (sut, presenterMock, _, _) = makeSut()
        
        let expectation = self.expectation(description: "waiting presenter to call presentFavoriteMovieChanged")
        
        presenterMock.onPresentCalled = {
            expectation.fulfill()
        }
        
        // When
        NotificationCenter.default.post(name: .favoriteMovieChanged, object: nil, userInfo: ["id": 1])
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            XCTAssertTrue(presenterMock.presentFavoriteMovieChangedCalled)
            XCTAssertEqual(presenterMock.presentFavoriteMovieChangedMovieID, 1)
        }
    }
}
