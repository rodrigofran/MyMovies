protocol MovieDetailDBWorkerProtocol {
    func doesFavoriteMovieExist(id: Int) throws -> Bool
    func saveFavoriteMovie(_ movie: FavoriteMovieModel) throws
    func removeFavoriteMovie(id: Int) throws
}

final class MovieDetailDBWorker: MovieDetailDBWorkerProtocol {
    
    private let dataManager: SwiftDataManagerProtocol
    
    init(dataManager: SwiftDataManagerProtocol = SwiftDataManager.shared) {
        self.dataManager = dataManager
    }
    
    func doesFavoriteMovieExist(id: Int) throws -> Bool {
        return try dataManager.doesFavoriteMovieExist(id: id)
    }
    
    func saveFavoriteMovie(_ movie: FavoriteMovieModel) throws {
        try dataManager.saveFavoriteMovie(movie)
    }
    
    func removeFavoriteMovie(id: Int) throws {
        try dataManager.removeFavoriteMovie(id: id)
    }
}
