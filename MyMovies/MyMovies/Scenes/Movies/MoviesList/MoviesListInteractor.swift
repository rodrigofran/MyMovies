import Foundation

protocol MoviesListBusinessLogic {
    func viewDidLoad(isFirstFetch: Bool)
}

class MoviesListInteractor: MoviesListBusinessLogic {
    private let presenter: MovieListPresentationLogic
    private let apiWorker: MovieListAPIWorkerProtocol
    private let dbWorker: MovieListDBWorkerProtocol
    private var isLoading = false
    private var totalPages: Int?
    private var currentPage: Int = 1

    
    init(presenter: MovieListPresentationLogic, apiWorker: MovieListAPIWorkerProtocol, dbWorker: MovieListDBWorkerProtocol) {
        self.presenter = presenter
        self.apiWorker = apiWorker
        self.dbWorker = dbWorker
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoriteMovieChanged(_:)), name: .favoriteMovieChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleFavoriteMovieChanged(_ notification: Notification) {
        if let movieID = notification.userInfo?["id"] as? Int {
            presenter.presentFavoriteMovieChanged(movieID: movieID)
        }
    }
    
    func viewDidLoad(isFirstFetch: Bool = true) {
        guard !isLoading else { return }
        if let totalPages = totalPages, currentPage > totalPages {
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let favoriteMovies = try dbWorker.fetchFavoritesMovies()
                let favoriteMovieIDs = Set(favoriteMovies.map { $0.id })
                
                let movieResponse = try await apiWorker.fetchMovies(page: currentPage)
                
                if totalPages == nil {
                    totalPages = movieResponse.totalPages
                }
                
                guard let results = movieResponse.results else { return }
                
                var loadedImages: [LoadedImage] = []
                for result in results {
                    async let posterImageData = self.loadImageData(for: result.posterPath)
                    async let backdropImageData = self.loadImageData(for: result.backdropPath)
                    
                    let loadedImage = LoadedImage(
                        movieID: result.id,
                        posterImageData: try await posterImageData,
                        backdropImageData: try await backdropImageData
                    )
                    
                    loadedImages.append(loadedImage)
                }
                
                if isFirstFetch {
                    await presenter.presentMoviesList(results: results, loadedImages: loadedImages, favoriteMovieIDs: favoriteMovieIDs)
                } else {
                    await presenter.presentNextMoviesList(results: results, loadedImages: loadedImages, favoriteMovieIDs: favoriteMovieIDs)
                }
                
                currentPage += 1
                isLoading = false
            } catch {
                isFirstFetch ? presenter.presentMoviesListWithError() : presenter.presentNextMoviesListWithError()
                isLoading = false
            }
            
        }
    }
    
    private func loadImageData(for path: String?) async throws -> Data? {
        guard let path = path else { return nil }
        let url = URL(string: "\(BaseURL.imageBaseURL)\(path)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
