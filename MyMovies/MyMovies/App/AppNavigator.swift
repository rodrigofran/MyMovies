import UIKit

final class AppNavigator {
    private(set) var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        let tabBarController = TabBarController()

        let moviesViewController = MoviesListConfigurator.configure()
        let favoritesViewController = FavoritesConfigurator.configure()

        let moviesNavController = UINavigationController(rootViewController: moviesViewController)
        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)

        tabBarController.setViewControllers(
            [moviesNavController, favoritesNavController],
            animated: false
        )

        if let items = tabBarController.tabBar.items {
            items[0].title = "Movies"
            items[0].image = UIImage(named: "movieListIcon")
            
            items[1].title = "Favorites"
            items[1].image = UIImage(named: "favoriteIcon")
        }

        navigationController.setViewControllers([tabBarController], animated: true)
        navigationController.navigationBar.isHidden = true
    }
}
