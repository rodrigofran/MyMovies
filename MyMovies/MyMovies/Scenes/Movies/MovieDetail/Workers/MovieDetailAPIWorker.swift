import NetworkKit

protocol MovieDetailAPIWorkerProtocol {
    func fetchGenres() async throws -> Genres
}

final class MovieDetailAPIWorker: MovieDetailAPIWorkerProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchGenres() async throws -> Genres {
        let dto = APIRequest(
            baseURL: BaseURL.apiBaseURL,
            queryParameters: [("language", "en-US")],
            paths: ["3", "genre", "movie", "list"],
            method: .GET
        )
        return try await networkService.performRequest(with: dto)
        
    }
}
