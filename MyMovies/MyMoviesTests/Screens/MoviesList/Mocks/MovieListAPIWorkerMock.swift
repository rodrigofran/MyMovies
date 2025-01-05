@testable import MyMovies
import Foundation

final class MovieListAPIWorkerMock: MovieListAPIWorkerProtocol {
    
    var fetchMoviesCalled = false
    var fetchMoviesPage: Int?
    var fetchMoviesToReturn: Movie?
    var fetchMoviesError: Error?
    
    func fetchMovies(page: Int) async throws -> Movie {
        fetchMoviesCalled = true
        fetchMoviesPage = page
        if let error = fetchMoviesError {
            throw error
        }
        
        if let movie = fetchMoviesToReturn {
            return movie
        } else {
            throw NSError(domain: "MovieListAPIWorkerMock", code: 404, userInfo: [NSLocalizedDescriptionKey: "Movie not found"])
        }
    }
}
