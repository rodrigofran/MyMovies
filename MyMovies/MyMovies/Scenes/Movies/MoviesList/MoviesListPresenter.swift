import UIKit

protocol MovieListPresentationLogic {
    func presentMoviesList(results: [MoviesResult], favoriteMovieIDs: Set<Int>) async
    func presentMoviesListWithError()
    func presentNextMoviesList(results: [MoviesResult], favoriteMovieIDs: Set<Int>) async
    func presentNextMoviesListWithError()
    func presentFavoriteMovieChanged(movieID: Int)
}

class MovieListPresenter: MovieListPresentationLogic {
    
    weak var viewController: MovieListDisplayLogic?
    
    func presentMoviesList(results: [MoviesResult], favoriteMovieIDs: Set<Int>) async {
        
        do {
            let loadedResults = try await loadImages(for: results, favoritesMoviesIds: favoriteMovieIDs)
            
            DispatchQueue.main.async  { [weak self] in
                guard let self = self else { return }
                self.viewController?.displayMovies(movies: loadedResults)
            }
        } catch {
            self.presentNextMoviesListWithError()
        }
    }
    
    func presentMoviesListWithError() {
        DispatchQueue.main.async  { [weak self] in
            guard let self = self else { return }
            self.viewController?.displayMoviesWithError()
        }
    }
    
    func presentNextMoviesList(results: [MoviesResult], favoriteMovieIDs: Set<Int>) async {
        
        do {
            let loadedResults = try await loadImages(for: results, favoritesMoviesIds: favoriteMovieIDs)
            
            DispatchQueue.main.async  { [weak self] in
                guard let self = self else { return }
                self.viewController?.displayNextMovies(movies: loadedResults)
            }
        } catch {
            self.presentNextMoviesListWithError()
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
    
    private func loadImages(for results: [MoviesResult], favoritesMoviesIds: Set<Int>) async throws -> [LoadedResult] {
        
        return try await withThrowingTaskGroup(of: LoadedResult.self) { group in
            var loadedResults: [LoadedResult] = []
            
            for result in results {
                group.addTask {
                    var posterImage: UIImage? = nil
                    var backdropImage: UIImage? = nil
                    
                    if let posterPath = result.posterPath {
                        let posterURL = URL(string: "\(BaseURL.imageBaseURL)\(posterPath)")!
                        let posterData = try Data(contentsOf: posterURL)
                        posterImage = UIImage(data: posterData)
                    }
                    
                    if let backdropPath = result.backdropPath {
                        let backdropURL = URL(string: "\(BaseURL.imageBaseURL)\(backdropPath)")!
                        let backdropData = try Data(contentsOf: backdropURL)
                        backdropImage = UIImage(data: backdropData)
                    }
                    
                    let isFavorited = favoritesMoviesIds.contains(result.id ?? 0)
                    
                    
                    return LoadedResult(
                        genreIds: result.genreIds,
                        id: result.id,
                        title: result.title,
                        overview: result.overview,
                        backdropPath: result.backdropPath,
                        posterPath: result.posterPath,
                        releaseDate: result.releaseDate?.extractYear(),
                        posterImage: posterImage,
                        backdropImage: backdropImage,
                        isFavorited: isFavorited
                    )
                }
            }
            
            for try await loadedResult in group {
                loadedResults.append(loadedResult)
            }
            
            return loadedResults
        }
    }
}

