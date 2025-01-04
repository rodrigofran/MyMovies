import UIKit

struct Movie: Decodable, Equatable {
    let page: Int?
    let results: [MoviesResult]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MoviesResult: Decodable, Equatable {
    let genreIds: [Int]?
    let id: Int?
    let title: String?
    let overview: String?
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case genreIds = "genre_ids"
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

class LoadedResult: Equatable {
    let genreIds: [Int]?
    let id: Int?
    let title: String?
    let overview: String?
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    let posterImage: UIImage?
    let backdropImage: UIImage?
    var isFavorited: Bool

    init(genreIds: [Int]?,
         id: Int?,
         title: String?,
         overview: String?,
         backdropPath: String?,
         posterPath: String?,
         releaseDate: String?,
         posterImage: UIImage?,
         backdropImage: UIImage?,
         isFavorited: Bool) {
        self.genreIds = genreIds
        self.id = id
        self.title = title
        self.overview = overview
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.posterImage = posterImage
        self.backdropImage = backdropImage
        self.isFavorited = isFavorited
    }

    func changeFavoriteStatus() {
        self.isFavorited.toggle()
    }

    static func == (lhs: LoadedResult, rhs: LoadedResult) -> Bool {
        return lhs.id == rhs.id
    }
}


