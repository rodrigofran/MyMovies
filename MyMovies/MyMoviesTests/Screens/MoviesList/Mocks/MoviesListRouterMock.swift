@testable import MyMovies

class MoviesListRouterMock: MoviesListRoutingLogic {
    var navigateToMovieDetailCalled = false

    func navigateToMovieDetail(movie: LoadedResult) {
        navigateToMovieDetailCalled = true
    }
}
