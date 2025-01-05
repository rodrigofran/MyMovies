@testable import MyMovies

final class FavoritesRouterMock: FavoritesRoutingLogic {
    
    var navigateToMovieDetailCalled = false
    var navigateToMovieDetailParameter: LoadedResult?
    
    func navigateToMovieDetail(movie: LoadedResult) {
        navigateToMovieDetailCalled = true
        navigateToMovieDetailParameter = movie
    }
}
