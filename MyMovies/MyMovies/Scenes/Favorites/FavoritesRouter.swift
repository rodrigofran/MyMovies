import UIKit

protocol FavoritesRoutingLogic {
    func navigateToMovieDetail(movie: LoadedResult)
}

class FavoritesRouter: FavoritesRoutingLogic {
    weak var viewController: UIViewController?

    func navigateToMovieDetail(movie: LoadedResult) {
        let movieDetailVC = MoviesDetailConfigurator.configure(movie: movie)
        viewController?.navigationController?.present(movieDetailVC, animated: true)
    }
}
