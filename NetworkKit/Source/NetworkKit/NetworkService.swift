//
//  NetworkService.swift
//  NetworkKit
//
//  Created by Rodrigo Francischett Occhiuto on 20/10/24.
//

import Foundation

public protocol NetworkServiceProtocol {
    func performRequest<T: Decodable>(with apiRequest: APIRequestProtocol) async throws -> T
}

public struct NetworkService: NetworkServiceProtocol {
    
    public let networkClient: NetworkClientProtocol
    
    public init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    public func performRequest<T: Decodable>(with apiRequest: APIRequestProtocol) async throws -> T {
        let urlRequest = try RequestBuilder.buildRequest(for: apiRequest)
        return try await networkClient.sendRequest(with: urlRequest)
    }
}
