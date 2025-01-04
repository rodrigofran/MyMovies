protocol MovieListDBWorkerProtocol {
    func doesFavoriteMovieExist(id: Int) throws -> Bool
    func fetchFavoritesMovies() throws -> [FavoriteMovieModel]
}

final class MovieListDBWorker: MovieListDBWorkerProtocol {
    
    private let dataManager: SwiftDataManagerProtocol
    
    init(dataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.dataManager = dataManager
    }
    
    func doesFavoriteMovieExist(id: Int) throws -> Bool {
        return try dataManager.doesFavoriteMovieExist(id: id)
    }
    
    func fetchFavoritesMovies() throws -> [FavoriteMovieModel] {
        let favoriteMovies = try dataManager.fetchAllFavoriteMovies()
        return favoriteMovies
    }
}
