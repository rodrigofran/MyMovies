import UIKit

enum MoviesListConfigurator {
    static func configure() -> UIViewController  {
        let apiWorker = MovieListAPIWorker()
        let dbWorker = MovieListDBWorker()
        let presenter = MovieListPresenter()
        let interactor = MoviesListInteractor(presenter: presenter, apiWorker: apiWorker, dbWorker: dbWorker)
        let router = MoviesListRouter()
        let viewController = MoviesListViewController(interactor: interactor, router: router)
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        
        return viewController
    }
}
