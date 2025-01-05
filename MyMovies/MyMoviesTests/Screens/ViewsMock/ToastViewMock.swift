@testable import MyMovies
import UIKit

final class ToastViewMock: ToastView {
    var showCalled = false
    var receivedMessage: String?
    var receivedBackgroundColor: UIColor?

    func show(message: String, backgroundColor: UIColor) {
        showCalled = true
        receivedMessage = message
        receivedBackgroundColor = backgroundColor
    }
}
