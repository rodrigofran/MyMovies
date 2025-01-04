import UIKit
import NetworkKit

enum FavoritesConfigurator {
    static func configure() -> UIViewController  {
        let dbWorker = FavoritesDBWorker()
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor(presenter: presenter, dbWorker: dbWorker)
        let router = FavoritesRouter()
        let viewController = FavoritesMoviesViewController(interactor: interactor, router: router)
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
