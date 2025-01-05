@testable import MyMovies

class MovieDetailAPIWorkerMock: MovieDetailAPIWorkerProtocol {
    var fetchGenresCalled = false
    
    func fetchGenres() async throws -> Genres {
        fetchGenresCalled = true
        return Genres(genres: [.fixture()])
    }
}
