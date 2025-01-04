import Foundation

protocol FavoritesPresentationLogic {
    func presentFavoritesMovies(favoritesMovies: [FavoriteMovieModel])
    func presentRemovedFavoriteMovie(indexPath: IndexPath)
    func presentErrorDb()
}

class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?
    
    func presentFavoritesMovies(favoritesMovies: [FavoriteMovieModel]) {
        self.viewController?.displayFavoritesMovies(favoritesMovies: favoritesMovies)
    }
    
    func presentRemovedFavoriteMovie(indexPath: IndexPath) {
        let errorMessage = "Movie removed from favorites"
        self.viewController?.displayRemovedFavoriteMovie(at: indexPath, errorMessage)
    }
    
    func presentErrorDb() {
        let errorMessage = "Unable to remove movie from favorites"
        self.viewController?.displayErrorDatabase(errorMessage)
    }
}
