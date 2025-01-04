import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.tintColor = UIColor.secondary
        tabBar.unselectedItemTintColor = .white
        tabBar.backgroundColor = UIColor.primary
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.primary
        self.tabBar.standardAppearance = appearance;
        self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
}

