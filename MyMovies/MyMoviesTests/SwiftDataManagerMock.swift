@testable import MyMovies

final class SwiftDataManagerMock: SwiftDataManagerProtocol {
    var favoriteMovies: [FavoriteMovieModel] = []
    var didSaveMovie = false
    var didRemoveMovie = false
    var error: Error?
    
    func saveFavoriteMovie(_ dto: FavoriteMovieModel) throws {
        if let error = error {
            throw error
        }
        favoriteMovies.append(dto)
        didSaveMovie = true
    }
     
    func fetchAllFavoriteMovies() throws -> [FavoriteMovieModel] {
        if let error = error {
            throw error
        }
        return favoriteMovies
    }
    
    func removeFavoriteMovie(id: Int) throws {
        if let error = error {
            throw error
        }
        favoriteMovies.removeAll { $0.id == id }
        didRemoveMovie = true
    }
    
    func doesFavoriteMovieExist(id: Int) throws -> Bool {
        if let error = error {
            throw error
        }
        return favoriteMovies.contains { $0.id == id }
    }
}
