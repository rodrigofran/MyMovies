protocol FavoritesDBWorkerProtocol {
    func fetchFavoritesMovies() throws -> [FavoriteMovieModel]
    func removeFavoriteMovie(id: Int) throws
}

final class FavoritesDBWorker: FavoritesDBWorkerProtocol {
    
    private let dataManager: SwiftDataManagerProtocol
    
    init(dataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.dataManager = dataManager
    }
    
    func fetchFavoritesMovies() throws -> [FavoriteMovieModel] {
        let favoriteMovies = try dataManager.fetchAllFavoriteMovies()
        return favoriteMovies
    }
    
    func removeFavoriteMovie(id: Int) throws {
        try dataManager.removeFavoriteMovie(id: id)
    }
}
