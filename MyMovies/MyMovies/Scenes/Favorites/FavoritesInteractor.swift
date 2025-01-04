import Foundation

protocol FavoritesBusinessLogic {
    func viewWillAppear()
    func removeFavoriteMovie(id: Int, indexPath: IndexPath)
}

class FavoritesInteractor: FavoritesBusinessLogic {
    
    private let presenter: FavoritesPresentationLogic
    private let dbWorker: FavoritesDBWorkerProtocol
    private var isLoading = false

    
    init(presenter: FavoritesPresentationLogic, dbWorker: FavoritesDBWorkerProtocol) {
        self.presenter = presenter
        self.dbWorker = dbWorker
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteMovieChanged(_:)), name: .favoriteMovieChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleFavoriteMovieChanged(_ notification: Notification) {
        guard notification.object as? FavoritesInteractor !== self else { return }
        viewWillAppear()
    }
    
    func viewWillAppear() {
        do {
            let favoriteMovies = try dbWorker.fetchFavoritesMovies()
            presenter.presentFavoritesMovies(favoritesMovies: favoriteMovies)
            
        } catch {
            presenter.presentErrorDb()
        }
    }
    
    func removeFavoriteMovie(id: Int, indexPath: IndexPath) {
        do {
            try dbWorker.removeFavoriteMovie(id: id)
            NotificationCenter.default.post(name: .favoriteMovieChanged, object: self, userInfo: ["id": id])
            
            presenter.presentRemovedFavoriteMovie(indexPath: indexPath)
        } catch {
            presenter.presentErrorDb()
        }
    }
}
