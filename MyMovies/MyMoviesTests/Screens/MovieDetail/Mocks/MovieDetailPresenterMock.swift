@testable import MyMovies

import Foundation

class MovieDetailPresenterMock: MovieDetailPresentationLogic {
    var presentAllGenresCalled = false
    var presentAllGenresWithErrorCalled = false
    var presentSavedFavoriteMovieCalled = false
    var presentRemovedFavoriteMovieCalled = false
    var presentErrorDbCalled = false
    var onPresentCalled: (() -> Void)?
    
    func presentAllGenres(_ genres: [Genre]) {
        presentAllGenresCalled = true
        onPresentCalled?()
    }
    
    func presentAllGenresWithError() {
        presentAllGenresWithErrorCalled = true
        onPresentCalled?()
    }
    
    func presentSavedFavoriteMovie() {
        presentSavedFavoriteMovieCalled = true
    }
    
    func presentRemovedFavoriteMovie() {
        presentRemovedFavoriteMovieCalled = true
    }
    
    func presentErrorDb() {
        presentErrorDbCalled = true
    }
}
