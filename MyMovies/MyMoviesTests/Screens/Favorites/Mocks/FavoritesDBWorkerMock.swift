@testable import MyMovies

final class FavoritesDBWorkerMock: FavoritesDBWorkerProtocol {
    
    var fetchFavoritesMoviesCalled = false
    var removeFavoriteMovieCalled = false
    
    var favoriteMoviesToReturn: [FavoriteMovieModel] = []
    var fetchFavoritesMoviesError: Error?
    var removeFavoriteMovieError: Error?
    
    func fetchFavoritesMovies() throws -> [FavoriteMovieModel] {
        fetchFavoritesMoviesCalled = true
        if let error = fetchFavoritesMoviesError {
            throw error
        }
        return favoriteMoviesToReturn
    }
    
    func removeFavoriteMovie(id: Int) throws {
        removeFavoriteMovieCalled = true
        if let error = removeFavoriteMovieError {
            throw error
        }
    }
}
