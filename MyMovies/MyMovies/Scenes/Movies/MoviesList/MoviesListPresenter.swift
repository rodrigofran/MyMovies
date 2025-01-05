import UIKit

protocol MovieListPresentationLogic {
    func presentMoviesList(results: [MoviesResult], loadedImages: [LoadedImage], favoriteMovieIDs: Set<Int>) async
    func presentMoviesListWithError()
    func presentNextMoviesList(results: [MoviesResult], loadedImages: [LoadedImage], favoriteMovieIDs: Set<Int>) async
    func presentNextMoviesListWithError()
    func presentFavoriteMovieChanged(movieID: Int)
}

class MovieListPresenter: MovieListPresentationLogic {
    
    weak var viewController: MoviesListDisplayLogic?
    
    func presentMoviesList(results: [MoviesResult], loadedImages: [LoadedImage], favoriteMovieIDs: Set<Int>) {
        let movies = buildLoadedResults(results: results, loadedImages: loadedImages, favoriteMovieIDs: favoriteMovieIDs)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayMovies(movies: movies)
        }
    }
    
    func presentMoviesListWithError() {
        DispatchQueue.main.async  { [weak self] in
            guard let self = self else { return }
            self.viewController?.displayMoviesWithError()
        }
    }
    
    func presentNextMoviesList(results: [MoviesResult], loadedImages: [LoadedImage], favoriteMovieIDs: Set<Int>) {
        
        let movies = buildLoadedResults(results: results, loadedImages: loadedImages, favoriteMovieIDs: favoriteMovieIDs)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayNextMovies(movies: movies)
        }
    }
    
    func presentNextMoviesListWithError() {
        DispatchQueue.main.async  { [weak self] in
            guard let self = self else { return }
            self.viewController?.displayNextMoviesWithError()
        }
    }
    
    func presentFavoriteMovieChanged(movieID: Int) {
        DispatchQueue.main.async  { [weak self] in
            guard let self = self else { return }
            self.viewController?.updateFavoriteMovieStatus(movieID: movieID)
        }
    }
    
    private func buildLoadedResults(results: [MoviesResult], loadedImages: [LoadedImage], favoriteMovieIDs: Set<Int>) -> [LoadedResult] {
        var loadedResults: [LoadedResult] = []
        
        for result in results {
            let image = loadedImages.first(where: { $0.movieID == result.id })
            
            let posterImage = image?.posterImageData.flatMap { UIImage(data: $0) }
            let backdropImage = image?.backdropImageData.flatMap { UIImage(data: $0) }
            
            let loadedResult = LoadedResult(
                genreIds: result.genreIds,
                id: result.id,
                title: result.title,
                overview: result.overview,
                backdropPath: result.backdropPath,
                posterPath: result.posterPath,
                releaseDate: result.releaseDate?.extractYear(),
                posterImage: posterImage,
                backdropImage: backdropImage,
                isFavorited: favoriteMovieIDs.contains(result.id ?? 0)
            )
            
            loadedResults.append(loadedResult)
        }
        
        return loadedResults
    }
}

