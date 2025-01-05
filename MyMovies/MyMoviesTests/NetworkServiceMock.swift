import NetworkKit

final class NetworkServiceMock: NetworkServiceProtocol {
    var didPerformRequest = false
    var returnValue: Decodable?
    var error: Error?
    
    func performRequest<T>(with apiRequest: APIRequestProtocol) async throws -> T where T: Decodable {
        didPerformRequest = true
        
        if let error = error {
            throw error
        }
        
        guard let result = returnValue as? T else {
            fatalError("Mock not configured correctly: expected return type \(T.self)")
        }
        
        return result
    }
}
