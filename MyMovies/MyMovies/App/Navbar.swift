import UIKit

extension UIViewController {
    func setupNavigationBar(
        title: String? = nil,
        showBackButton: Bool = false,
        showCloseButton: Bool = false,
        backButtonAction: Selector? = nil,
        closeButtonAction: Selector? = nil
    ) {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.primary
        appearance.titleTextAttributes = [.foregroundColor: UIColor.secondary]
        navigationBar.standardAppearance = appearance;
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        navigationBar.tintColor = UIColor.secondary
        
        self.title = title
        
        if showBackButton {
            let backButton = UIBarButtonItem(
                image: UIImage(systemName: "arrow.left"),
                style: .plain,
                target: self,
                action: backButtonAction ?? #selector(defaultBackButtonTapped)
            )
            
            backButton.tintColor = .black
            navigationItem.leftBarButtonItem = backButton
        }

        if showCloseButton {
            let closeButton = UIBarButtonItem(
                image: UIImage(systemName: "xmark"), // Ícone padrão do SF Symbols
                style: .plain,
                target: self,
                action: closeButtonAction ?? #selector(defaultCloseButtonTapped)
            )
            navigationItem.rightBarButtonItem = closeButton
        }
    }
    @objc private func defaultBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func defaultCloseButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
