import XCTest
@testable import MyMovies


final class MoviesListRouterTests: XCTestCase {
    //MARK: - SUT & Mocks
    
    private func makeSut(
        viewControllerMock: MovieListViewControllerMock = MovieListViewControllerMock()
    ) -> (MoviesListRouter, MovieListViewControllerMock) {
        let sut = MoviesListRouter()
        sut.viewController = viewControllerMock
        return (sut, viewControllerMock)
    }
    
    // MARK: - Tests
    
    func test_navigateToMovieDetail_shouldPresentExpectedViewController() {
        // Given
        let (sut, viewControllerMock) = makeSut()
        let movie = LoadedResult.fixture()
        
        // When
        sut.navigateToMovieDetail(movie: movie)
        
        // Then
        XCTAssertNotNil(viewControllerMock.capturedPresentedViewController)
        XCTAssertTrue(viewControllerMock.capturedPresentedViewController is MovieDetailViewController)
    }
}

