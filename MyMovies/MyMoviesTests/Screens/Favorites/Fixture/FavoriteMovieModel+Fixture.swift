@testable import MyMovies
import Foundation

extension FavoriteMovieModel {
    static func fixture(
        id: Int = 1,
        title: String = "Test Movie",
        overview: String = "Test Overview",
        releaseDate: String = "2025-01-01",
        imageData: Data = Data(),
        genresIds: [Int]? = [1, 2]
    ) -> FavoriteMovieModel {
        return FavoriteMovieModel(
            id: id,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            imageData: imageData,
            genresIds: genresIds
        )
    }
}
