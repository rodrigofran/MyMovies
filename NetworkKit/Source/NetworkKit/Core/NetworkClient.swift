//
//  NetworkClient.swift
//  NetworkKit
//
//  Created by Rodrigo Francischett Occhiuto on 20/10/24.
//

import Foundation

public protocol NetworkClientProtocol {
    func sendRequest<T: Decodable>(with request: URLRequest) async throws -> T
}

public final class NetworkClient: NetworkClientProtocol {
    private let urlSession: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    public func sendRequest<T: Decodable>(with request: URLRequest) async throws -> T {
        let (data, response) = try await urlSession.fetchData(for: request)
        
        try ResponseHandler.validateResponse(response)
        
        return try JSONDecoderService.decode(data: data)
    }
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await self.data(for: request)
    }
}


