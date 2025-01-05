import UIKit
@testable import MyMovies


final class FavoritesViewControllerMock: UIViewController, FavoritesDisplayLogic {
    
    var displayFavoritesMoviesCalled = false
    var displayRemovedFavoriteMovieCalled = false
    var displayErrorDatabaseCalled = false
    
    var receivedFavoriteMovies: [FavoriteMovieModel] = []
    var receivedIndexPath: IndexPath?
    var receivedErrorMessage: String?
    
    func displayFavoritesMovies(favoritesMovies: [FavoriteMovieModel]) {
        displayFavoritesMoviesCalled = true
        receivedFavoriteMovies = favoritesMovies
    }
    
    func displayRemovedFavoriteMovie(at indexPath: IndexPath, _ message: String) {
        displayRemovedFavoriteMovieCalled = true
        receivedIndexPath = indexPath
        receivedErrorMessage = message
    }
    
    func displayErrorDatabase(_ message: String) {
        displayErrorDatabaseCalled = true
        receivedErrorMessage = message
    }
    
    //MARK: - Capturing ViewController
    
    var presentHandler: ((UIViewController, Bool) -> Void)?
    var capturedPresentedViewController: UIViewController?
    var capturedAnimatedFlag: Bool?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        capturedPresentedViewController = viewControllerToPresent
        capturedAnimatedFlag = flag
        presentHandler?(viewControllerToPresent, flag)
        completion?()
    }
}
