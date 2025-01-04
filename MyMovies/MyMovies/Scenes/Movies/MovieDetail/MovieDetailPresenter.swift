import Foundation

protocol MovieDetailPresentationLogic {
    func presentAllGenres(_ genres: [Genre])
    func presentAllGenresWithError(_ error: Error)
    func presentSavedFavoriteMovie()
    func presentRemovedFavoriteMovie()
    func presentErrorDb()
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    weak var viewController: MovieDetailDisplayLogic?
    
    func presentAllGenres(_ genres: [Genre]) {
        guard let movieGenreIds = viewController?.getMovieGenreIds() else {
            DispatchQueue.main.async {
                self.viewController?.displayGenres(labelText: nil, hide: true)
            }
            return
        }
        
        let genreNames = movieGenreIds
            .compactMap { genreId in genres.first(where: { $0.id == genreId })?.name }
            .joined(separator: ", ")
        
        DispatchQueue.main.async {
            if genreNames.isEmpty {
                self.viewController?.displayGenres(labelText: nil, hide: true)
            } else {
                self.viewController?.displayGenres(labelText: genreNames, hide: false)
            }
        }
    }
    
    func presentAllGenresWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.viewController?.displayErrorFetchingGenres(error: error)
        }
    }
    
    func presentSavedFavoriteMovie() {
        DispatchQueue.main.async {
            self.viewController?.displaySavedFavoriteMovie(true)
        }
    }
    
    func presentRemovedFavoriteMovie() {
        DispatchQueue.main.async {
            self.viewController?.displayRemovedFavoriteMovie(false)
        }
    }
    
    func presentErrorDb() {
        DispatchQueue.main.async {
            self.viewController?.displayErrorDatabase()
        }
    }
}
