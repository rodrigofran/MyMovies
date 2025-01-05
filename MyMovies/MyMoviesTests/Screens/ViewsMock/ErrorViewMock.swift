@testable import MyMovies
import UIKit

final class ErrorViewMock: ErrorView {
    var configureCalled = false
    var receivedImage: UIImage?
    var receivedText: String?
    var hideRetryButton: Bool?
    var onRetryCalled: (() -> Void)?

    override func configure(image: UIImage?, text: String, hideRetryButton: Bool = false, onRetry: @escaping () -> Void) {
        configureCalled = true
        receivedImage = image
        receivedText = text
        self.hideRetryButton = hideRetryButton
        self.onRetryCalled = onRetry
    }
}
