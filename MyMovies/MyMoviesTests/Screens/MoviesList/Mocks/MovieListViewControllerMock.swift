@testable import MyMovies
import UIKit

final class MovieListViewControllerMock: UIViewController, MoviesListDisplayLogic {
    var displayMoviesCalled = false
    var displayMovies: [LoadedResult]?
    
    var displayMoviesWithErrorCalled = false
    
    var displayNextMoviesCalled = false
    var displayNextMovies: [LoadedResult]?
    
    var displayNextMoviesWithErrorCalled = false
    
    var updateFavoriteMovieStatusCalled = false
    var updateFavoriteMovieStatusMovieID: Int?
    
    var onDisplayCalled: (() -> Void)?
    
    func displayMovies(movies: [LoadedResult]) {
        displayMoviesCalled = true
        displayMovies = movies
        onDisplayCalled?()
    }
    
    func displayMoviesWithError() {
        displayMoviesWithErrorCalled = true
        onDisplayCalled?()
    }
    
    func displayNextMovies(movies: [LoadedResult]) {
        displayNextMoviesCalled = true
        displayNextMovies = movies
        onDisplayCalled?()
    }
    
    func displayNextMoviesWithError() {
        displayNextMoviesWithErrorCalled = true
        onDisplayCalled?()
    }
    
    func updateFavoriteMovieStatus(movieID: Int) {
        updateFavoriteMovieStatusCalled = true
        updateFavoriteMovieStatusMovieID = movieID
        onDisplayCalled?()
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
