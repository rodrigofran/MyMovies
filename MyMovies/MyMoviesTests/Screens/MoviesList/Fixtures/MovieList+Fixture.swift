@testable import MyMovies
import UIKit

extension MoviesResult {
    static func fixture(
        genreIds: [Int]? = [1],
        id: Int? = 101,
        title: String? = "Test Movie",
        overview: String? = "This is a test movie.",
        backdropPath: String? = "/backdrop.jpg",
        posterPath: String? = "/poster.jpg",
        releaseDate: String? = "2023-12-01"
    ) -> MoviesResult {
        return .init(
            genreIds: genreIds,
            id: id,
            title: title,
            overview: overview,
            backdropPath: backdropPath,
            posterPath: posterPath,
            releaseDate: releaseDate
        )
    }
}

extension Movie {
    static func fixture(
        page: Int? = 1,
        results: [MoviesResult]? = [.fixture()],
        totalPages: Int? = 1,
        totalResults: Int? = 10
    ) -> Movie {
        return .init(
            page: page,
            results: results,
            totalPages: totalPages,
            totalResults: totalResults
        )
    }
}

extension LoadedResult {
    static func fixture(
        genreIds: [Int]? = [1],
        id: Int? = 101,
        title: String? = "Loaded Movie",
        overview: String? = "This is a loaded test movie.",
        backdropPath: String? = "/loaded_backdrop.jpg",
        posterPath: String? = "/loaded_poster.jpg",
        releaseDate: String? = "2023-12-01",
        posterImage: UIImage? = UIImage(systemName: "film"),
        backdropImage: UIImage? = UIImage(systemName: "film"),
        isFavorited: Bool = false
    ) -> LoadedResult {
        return .init(
            genreIds: genreIds,
            id: id,
            title: title,
            overview: overview,
            backdropPath: backdropPath,
            posterPath: posterPath,
            releaseDate: releaseDate,
            posterImage: posterImage,
            backdropImage: backdropImage,
            isFavorited: isFavorited
        )
    }
}

extension LoadedImage {
    static func fixture(
        movieId: Int = 1,
        posterImageData: Data = Data(),
        backdropImageData: Data = Data()
    ) -> LoadedImage {
        return .init(
            movieID: movieId,
            posterImageData: posterImageData,
            backdropImageData: backdropImageData)
    }
}
