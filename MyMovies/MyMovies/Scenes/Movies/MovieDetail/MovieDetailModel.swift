struct Genres: Decodable, Equatable {
    let genres: [Genre]
}

struct Genre: Decodable, Equatable {
    let id: Int?
    let name: String?
}
