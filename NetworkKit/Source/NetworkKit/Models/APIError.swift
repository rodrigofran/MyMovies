//
//  APIError.swift
//  NetworkKit
//
//  Created by Rodrigo Francischett Occhiuto on 20/10/24.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingFailed
    case unknown
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from the server."
        case .serverError(let statusCode):
            return "Server returned an error with status code: \(statusCode)."
        case .decodingFailed:
            return "Failed to decode the response."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
