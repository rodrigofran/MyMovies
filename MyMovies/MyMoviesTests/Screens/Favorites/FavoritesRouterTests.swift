import XCTest
@testable import MyMovies


// MARK: - SUT & Mocks
final class FavoritesRouterTests: XCTestCase {
    //MARK: - SUT & Mocks
    
    private func makeSut(
        viewControllerMock: FavoritesViewControllerMock = FavoritesViewControllerMock()
    ) -> (FavoritesRouter, FavoritesViewControllerMock) {
        let sut = FavoritesRouter()
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
