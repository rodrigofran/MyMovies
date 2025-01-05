import XCTest
@testable import MyMovies

final class MovieDetailAPIWorkerTests: XCTestCase {
    // MARK: - SUT & Dummies
    private func makeSut(networkServiceMock: NetworkServiceMock = NetworkServiceMock()) -> (MovieDetailAPIWorker, NetworkServiceMock) {
        let sut = MovieDetailAPIWorker(networkService: networkServiceMock)
        return (sut, networkServiceMock)
    }
    
    // MARK: - Tests
    func test_fetchMovies_withValidResponse_shouldReturnMovies() async throws {
        // Given
        let (sut, networkServiceMock) = makeSut()
        let genres = Genres(genres: [.fixture()])
        networkServiceMock.returnValue = genres
        
        // When
        _ = try await sut.fetchGenres()
        
        // Then
        XCTAssertTrue(networkServiceMock.didPerformRequest)
        XCTAssertEqual(genres.genres[0].id, 1)
        XCTAssertEqual(genres.genres[0].name, "Drama")
    }
    
    func test_fetchMovies_withNetworkError_shouldThrowError() async {
        // Given
        let (sut, networkServiceMock) = makeSut()
        let mockError = NSError(domain: "test", code: 1, userInfo: nil)
        networkServiceMock.error = mockError
        
        do {
            // When
            _ = try await sut.fetchGenres()
            XCTFail("Should throw an error")
        } catch {
            // Then
            XCTAssertTrue(networkServiceMock.didPerformRequest)
            XCTAssertEqual((error as NSError).domain, "test")
            XCTAssertEqual((error as NSError).code, 1)
        }
    }
}
