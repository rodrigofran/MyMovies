import UIKit

enum MoviesDetailConfigurator {
    static func configure(movie: LoadedResult) -> UIViewController  {
        let apiWorker = MovieDetailAPIWorker()
        let dbWorker = MovieDetailDBWorker()
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor(presenter: presenter, apiWorker: apiWorker, dbWorker: dbWorker)
        let viewController = MovieDetailViewController(interactor: interactor, movie: movie)
        
        presenter.viewController = viewController
        
        
        return viewController
    }
}
