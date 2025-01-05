@testable import MyMovies

class MoviesListInteractorMock: MoviesListBusinessLogic {
    var viewDidLoadCalled = false

    func viewDidLoad(isFirstFetch: Bool) {
        viewDidLoadCalled = true
    }
}
