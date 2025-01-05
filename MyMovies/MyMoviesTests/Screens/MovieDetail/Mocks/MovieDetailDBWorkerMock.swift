@testable import MyMovies

class MovieDetailDBWorkerMock: MovieDetailDBWorkerProtocol {
    var saveFavoriteMovieCalled = false
    var removeFavoriteMovieCalled = false
    var doesFavoriteMovieExistResult = false
    var doesFavoriteMovieExistError: Error?
    
    func saveFavoriteMovie(_ movie: FavoriteMovieModel) throws {
        saveFavoriteMovieCalled = true
    }
    
    func removeFavoriteMovie(id: Int) throws {
        removeFavoriteMovieCalled = true
    }
    
    func doesFavoriteMovieExist(id: Int) throws -> Bool {
        if let error = doesFavoriteMovieExistError {
            throw error
        }
        return doesFavoriteMovieExistResult
    }
}
