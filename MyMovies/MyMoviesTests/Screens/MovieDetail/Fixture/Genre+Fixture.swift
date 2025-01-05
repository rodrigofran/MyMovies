@testable import MyMovies

extension Genre {
    static func fixture(
        id: Int? = 1,
        name: String? = "Drama"
    ) -> Genre {
        return .init(
            id: id,
            name: name
        )
    }
}
