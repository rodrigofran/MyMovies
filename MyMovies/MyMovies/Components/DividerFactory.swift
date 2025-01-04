import UIKit

extension UIView {
    static func makeDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.layer.opacity = 0.3
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return divider
    }
}
