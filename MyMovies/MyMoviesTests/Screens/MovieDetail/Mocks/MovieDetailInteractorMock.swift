@testable import MyMovies

class MovieDetailInteractorMock: MovielDetailBusinessLogic {
    var viewDidLoadCalled = false
    var addOrRemoveFavoritesCalled = false
    var movieToFavorite: LoadedResult?
    var movieIdToFavorite: Int?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func addOrRemoveFavorites(movie: LoadedResult, id: Int) {
        addOrRemoveFavoritesCalled = true
        movieToFavorite = movie
        movieIdToFavorite = id
    }
}
