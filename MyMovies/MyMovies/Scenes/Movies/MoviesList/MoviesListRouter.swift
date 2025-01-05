import UIKit

protocol MoviesListRoutingLogic {
    func navigateToMovieDetail(movie: LoadedResult)
}

class MoviesListRouter: MoviesListRoutingLogic {
    weak var viewController: UIViewController?

    func navigateToMovieDetail(movie: LoadedResult) {
        let movieDetailVC = MoviesDetailConfigurator.configure(movie: movie)
        viewController?.present(movieDetailVC, animated: true)
    }
}
