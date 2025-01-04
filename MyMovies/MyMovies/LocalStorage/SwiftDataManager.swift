import SwiftData
import Foundation

protocol SwiftDataManagerProtocol {
    func saveFavoriteMovie(_ dto: FavoriteMovieModel) throws
    func fetchAllFavoriteMovies() throws -> [FavoriteMovieModel]
    func removeFavoriteMovie(id: Int) throws
    func doesFavoriteMovieExist(id: Int) throws -> Bool
}

class SwiftDataManager: SwiftDataManagerProtocol {
    static let shared = SwiftDataManager()
    
    private var container: ModelContainer?
    private var context: ModelContext?
    private let defaultError = NSError(domain: "SwiftData", code: 1)
    
    private init() {
        do {
            let schema = Schema([FavoriteMovieModel.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            context = container.map { ModelContext($0) }
        } catch {
            print("Failed to initialize SwiftData container: \(error)")
        }
    }
    
    func saveFavoriteMovie(_ dto: FavoriteMovieModel) throws {
        let context = try getContext()
        guard try !doesFavoriteMovieExist(id: dto.id) else {
            throw defaultError
        }
        context.insert(dto)
        try context.save()
    }

    func fetchAllFavoriteMovies() throws -> [FavoriteMovieModel] {
        let context = try getContext()
        let fetchDescriptor = FetchDescriptor<FavoriteMovieModel>()
        return try context.fetch(fetchDescriptor)
    }

    func removeFavoriteMovie(id: Int) throws {
        let context = try getContext()
        let fetchDescriptor = FetchDescriptor<FavoriteMovieModel>(
            predicate: #Predicate { $0.id == id }
        )
        guard let movieToRemove = try context.fetch(fetchDescriptor).first else {
            throw defaultError
        }
        context.delete(movieToRemove)
        try context.save()
    }

    func doesFavoriteMovieExist(id: Int) throws -> Bool {
        let context = try getContext()
        let fetchDescriptor = FetchDescriptor<FavoriteMovieModel>(
            predicate: #Predicate { $0.id == id }
        )
        return try !context.fetch(fetchDescriptor).isEmpty
    }
    
    private func getContext() throws -> ModelContext {
        guard let container = container else {
            throw defaultError
        }
        return ModelContext(container)
    }
}
