@testable import MyMovies
import UIKit

class MovieDetailViewControllerMock: MovieDetailDisplayLogic {
    var stubMovieGenreIds: [Int]?
    var displayGenresLabelText: String?
    var isGenresLabelHidden = false
    var displayGenresCalled = false
    
    var displayErrorFetchingGenresCalled = false
    var errorMessage: String?
    
    var displaySavedFavoriteMovieCalled = false
    var isFavoriteButtonSelected = false
    var toastMessage: String?
    var toastBackgroundColor: UIColor?
    
    var displayRemovedFavoriteMovieCalled = false
    var displayErrorDatabaseCalled = false

    var onDisplayGenresCalled: (() -> Void)?
    
    func getMovieGenreIds() -> [Int]? {
        return stubMovieGenreIds
    }
    
    func displayGenres(labelText: String?, hide: Bool) {
        displayGenresCalled = true
        displayGenresLabelText = labelText
        isGenresLabelHidden = hide
        
        onDisplayGenresCalled?()
    }
    
    func displayErrorFetchingGenres() {
        displayErrorFetchingGenresCalled = true
        errorMessage = "Error fetching genres"
        
        onDisplayGenresCalled?()
    }
    
    func displaySavedFavoriteMovie(_ isFavorited: Bool) {
        displaySavedFavoriteMovieCalled = true
        isFavoriteButtonSelected = isFavorited
        toastMessage = "Movie added to favorites"
        toastBackgroundColor = UIColor.toastPositive
    }
    
    func displayRemovedFavoriteMovie(_ isFavorited: Bool) {
        displayRemovedFavoriteMovieCalled = true
        isFavoriteButtonSelected = isFavorited
        toastMessage = "Movie removed from favorites"
        toastBackgroundColor = UIColor.toastPositive
    }
    
    func displayErrorDatabase() {
        displayErrorDatabaseCalled = true
        toastMessage = "An error occurred while accessing the database"
    }
}
