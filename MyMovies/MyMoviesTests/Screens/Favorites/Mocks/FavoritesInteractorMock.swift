import Foundation
@testable import MyMovies

final class FavoritesInteractorMock: FavoritesBusinessLogic {
    
    var viewWillAppearCalled = false
    var removeFavoriteMovieCalled = false
    
    var removeFavoriteMovieParameters: (id: Int, indexPath: IndexPath)?
    
    func viewWillAppear() {
        viewWillAppearCalled = true
    }
    
    func removeFavoriteMovie(id: Int, indexPath: IndexPath) {
        removeFavoriteMovieCalled = true
        removeFavoriteMovieParameters = (id, indexPath)
    }
}
