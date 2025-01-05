import XCTest
@testable import MyMovies

final class MovieDetailPresenterTests: XCTestCase {
    
    // MARK: - SUT & Mocks
    private func makeSut() -> (MovieDetailPresenter, MovieDetailViewControllerMock) {
        let viewController = MovieDetailViewControllerMock()
        let sut = MovieDetailPresenter()
        sut.viewController = viewController
        return (sut, viewController)
    }
    
    // MARK: - Tests
    
    func test_presentAllGenres_shouldDisplayGenres() {
        // Given
        let (sut, viewController) = makeSut()
        let genres = [Genre.fixture(id: 1, name: "Action"), Genre.fixture(id: 2, name: "Drama")]
        let movieGenreIds = [1, 2]
        
        viewController.stubMovieGenreIds = movieGenreIds
        
        let expectation = expectation(description: "waiting presenter call displayGenres")
        
        viewController.onDisplayGenresCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.presentAllGenres(genres)
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertEqual(viewController.displayGenresLabelText, "Action, Drama")
            XCTAssertFalse(viewController.isGenresLabelHidden)
        }
    }
    
    func test_presentAllGenres_shouldHideGenresIfNoGenresFound() {
        // Given
        let (sut, viewController) = makeSut()
        let genres = [Genre.fixture(id: 1, name: "Action"), Genre.fixture(id: 2, name: "Drama")]
        let movieGenreIds = [3]
        
        viewController.stubMovieGenreIds = movieGenreIds
        
        let expectation = expectation(description: "waiting presenter call displayGenres")
        
        viewController.onDisplayGenresCalled = {
            expectation.fulfill()
        }
        // When
        sut.presentAllGenres(genres)
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertNil(viewController.displayGenresLabelText)
            XCTAssertTrue(viewController.isGenresLabelHidden)
        }
    }
    
    func test_presentAllGenresWithError_shouldDisplayErrorMessage() {
        // Given
        let (sut, viewController) = makeSut()
        
        let expectation = expectation(description: "waiting presenter call displayErrorFetchingGenres")
        
        viewController.onDisplayGenresCalled = {
            expectation.fulfill()
        }
        
        // When
        sut.presentAllGenresWithError()
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(viewController.displayErrorFetchingGenresCalled)
            XCTAssertEqual(viewController.errorMessage, "Error fetching genres")
        }
    }
}
