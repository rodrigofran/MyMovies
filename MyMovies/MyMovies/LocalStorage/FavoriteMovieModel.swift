import SwiftData
import Foundation

@Model
final class FavoriteMovieModel {
    @Attribute(.unique) var id: Int
    var title: String
    var overview: String
    var releaseDate: String
    var imageData: Data
    var genresIds: [Int]?
    
    init(
        id: Int,
        title: String,
        overview: String,
        releaseDate: String,
        imageData: Data,
        genresIds: [Int]?
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.imageData = imageData
        self.genresIds = genresIds
    }
}

enum Section {
    case favoriteMovie
}
