import XCTest
@testable import MyMovies

final class MovieListAPIWorkerTests: XCTestCase {
    // MARK: - SUT & Mocks
    private func makeSut(networkServiceMock: NetworkServiceMock = NetworkServiceMock()) -> (MovieListAPIWorker, NetworkServiceMock) {
        let sut = MovieListAPIWorker(networkService: networkServiceMock)
        return (sut, networkServiceMock)
    }
    
    // MARK: - Tests
    func test_fetchMovies_withValidResponse_shouldReturnMovies() async throws {
        // Given
        let (sut, networkServiceMock) = makeSut()
        let mockMovieResult = MoviesResult.fixture(id: 200, title: "First Movie")
        let mockMovie = Movie.fixture(results: [mockMovieResult])
        networkServiceMock.returnValue = mockMovie
        
        // When
        let movie = try await sut.fetchMovies(page: 1)
        
        // Then
        XCTAssertTrue(networkServiceMock.didPerformRequest)
        XCTAssertEqual(movie.results?[0].id, 200)
        XCTAssertEqual(movie.results?[0].title, "First Movie")
    }
    
    func test_fetchMovies_withNetworkError_shouldThrowError() async {
        // Given
        let (sut, networkServiceMock) = makeSut()
        let mockError = NSError(domain: "test", code: 1, userInfo: nil)
        networkServiceMock.error = mockError
        
        do {
            // When
            _ = try await sut.fetchMovies(page: 1)
            XCTFail("Should throw an error")
        } catch {
            // Then
            XCTAssertTrue(networkServiceMock.didPerformRequest)
            XCTAssertEqual((error as NSError).domain, "test")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
}
