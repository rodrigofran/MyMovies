import NetworkKit

protocol MovieListAPIWorkerProtocol {
    func fetchMovies(page: Int) async throws -> Movie
}

final class MovieListAPIWorker: MovieListAPIWorkerProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchMovies(page: Int) async throws -> Movie {
        let dto = APIRequest(
            baseURL: BaseURL.apiBaseURL,
            queryParameters: [("language", "en-US"), ("page", String(page))],
            paths: ["3", "movie", "popular"],
            method: .GET
        )
        return try await networkService.performRequest(with: dto)
    }
}
