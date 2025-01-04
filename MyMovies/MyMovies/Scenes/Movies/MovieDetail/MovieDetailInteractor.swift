import Foundation

protocol MovielDetailBusinessLogic {
    func viewDidLoad()
    func addOrRemoveFavorites(movie: LoadedResult, id: Int) throws
}

class MovieDetailInteractor: MovielDetailBusinessLogic {
    
    
    private let presenter: MovieDetailPresentationLogic
    private let apiWorker: MovieDetailAPIWorkerProtocol
    private let dbWorker: MovieDetailDBWorkerProtocol
    private var isLoading = false

    
    init(presenter: MovieDetailPresentationLogic, apiWorker: MovieDetailAPIWorkerProtocol, dbWorker: MovieDetailDBWorkerProtocol) {
        self.presenter = presenter
        self.apiWorker = apiWorker
        self.dbWorker = dbWorker
    }
    
    func viewDidLoad() {
        guard !isLoading else { return }
        
        isLoading = true
        
        Task {
            do {
                let genres = try await apiWorker.fetchGenres()
                presenter.presentAllGenres(genres.genres)
            } catch {
                presenter.presentAllGenresWithError(error)
            }
            isLoading = false
        }
    }
    
    func addOrRemoveFavorites(movie: LoadedResult, id: Int) {
        do {
            let exists = try dbWorker.doesFavoriteMovieExist(id: id)
            exists ? removeFavoriteMovie(id: id) : addFavorite(movie: movie)
            
            NotificationCenter.default.post(name: .favoriteMovieChanged, object: nil, userInfo: ["id": id])
        } catch {
            presenter.presentErrorDb()
        }
    }
    
    private func addFavorite(movie: LoadedResult) {
        guard let image = movie.backdropImage?.jpegData(compressionQuality: 0.8) else { return }
        let favoriteMovie = FavoriteMovieModel(
            id: movie.id ?? 999,
            title: movie.title ?? "",
            overview: movie.overview ?? "",
            releaseDate: movie.releaseDate ?? "",
            imageData: image,
            genresIds: movie.genreIds ?? []
        )
        
        do {
            try dbWorker.saveFavoriteMovie(favoriteMovie)
            presenter.presentSavedFavoriteMovie()
            
        } catch {
            presenter.presentErrorDb()
        }
    }
    
    private func removeFavoriteMovie(id: Int) {
        do {
            try dbWorker.removeFavoriteMovie(id: id)
            presenter.presentRemovedFavoriteMovie()
        } catch {
            presenter.presentErrorDb()
        }
    }
}
