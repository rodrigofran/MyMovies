import Foundation
@testable import MyMovies

final class FavoritesPresenterMock: FavoritesPresentationLogic {
    
    var presentFavoritesMoviesCalled = false
    var presentRemovedFavoriteMovieCalled = false
    var presentErrorDbCalled = false
    
    var receivedFavoritesMovies: [FavoriteMovieModel] = []
    var receivedIndexPath: IndexPath?
    
    func presentFavoritesMovies(favoritesMovies: [FavoriteMovieModel]) {
        presentFavoritesMoviesCalled = true
        receivedFavoritesMovies = favoritesMovies
    }
    
    func presentRemovedFavoriteMovie(indexPath: IndexPath) {
        presentRemovedFavoriteMovieCalled = true
        receivedIndexPath = indexPath
    }
    
    func presentErrorDb() {
        presentErrorDbCalled = true
    }
}
