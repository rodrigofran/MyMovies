@testable import MyMovies

final class MovieListDBWorkerMock: MovieListDBWorkerProtocol {
    
    var fetchFavoritesMoviesCalled = false
    var doesFavoriteMovieExistCalled = false
    var favoriteMoviesToReturn: [FavoriteMovieModel] = []
    var doesFavoriteMovieExistResult: Bool = false
    var fetchFavoritesMoviesError: Error?
    var doesFavoriteMovieExistError: Error?
    
    func fetchFavoritesMovies() throws -> [FavoriteMovieModel] {
        fetchFavoritesMoviesCalled = true
        if let error = fetchFavoritesMoviesError {
            throw error
        }
        return favoriteMoviesToReturn
    }
    
    func doesFavoriteMovieExist(id: Int) throws -> Bool {
        doesFavoriteMovieExistCalled = true
        if let error = doesFavoriteMovieExistError {
            throw error
        }
        return doesFavoriteMovieExistResult
    }
}
