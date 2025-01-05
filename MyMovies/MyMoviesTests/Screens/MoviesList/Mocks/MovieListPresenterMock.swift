@testable import MyMovies

class MovieListPresenterMock: MovieListPresentationLogic {
    
    // MARK: - Propriedades de verificação
    var presentMoviesListCalled = false
    var presentMoviesListMovies: [MoviesResult]?
    var presentMoviesListFavoriteIDs: Set<Int>?
    var presentMoviesListLoadedImages: [LoadedImage]?
    
    var presentMoviesListWithErrorCalled = false
    
    var presentNextMoviesListCalled = false
    var presentNextMoviesListMovies: [MoviesResult]?
    var presentNextMoviesListFavoriteIDs: Set<Int>?
    var presentNextMoviesListLoadedImages: [LoadedImage]?
    
    var presentNextMoviesListWithErrorCalled = false
    
    var presentFavoriteMovieChangedCalled = false
    var presentFavoriteMovieChangedMovieID: Int?
    
    var onPresentCalled: (() -> Void)?
    
    // MARK: - Métodos de Mock
    func presentMoviesList(results: [MoviesResult], loadedImages: [LoadedImage], favoriteMovieIDs: Set<Int>) {
        presentMoviesListCalled = true
        presentMoviesListMovies = results
        presentMoviesListFavoriteIDs = favoriteMovieIDs
        presentMoviesListLoadedImages = loadedImages
        onPresentCalled?()
    }
    
    func presentMoviesListWithError() {
        presentMoviesListWithErrorCalled = true
        onPresentCalled?()
    }
    
    func presentNextMoviesList(results: [MoviesResult], loadedImages: [LoadedImage], favoriteMovieIDs: Set<Int>) {
        presentNextMoviesListCalled = true
        presentNextMoviesListMovies = results
        presentNextMoviesListFavoriteIDs = favoriteMovieIDs
        presentNextMoviesListLoadedImages = loadedImages
        onPresentCalled?()
    }
    
    func presentNextMoviesListWithError() {
        presentNextMoviesListWithErrorCalled = true
        onPresentCalled?()
    }
    
    func presentFavoriteMovieChanged(movieID: Int) {
        presentFavoriteMovieChangedCalled = true
        presentFavoriteMovieChangedMovieID = movieID
        onPresentCalled?()
    }
}
