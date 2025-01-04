//
//  ResponseHandler.swift
//  NetworkKit
//
//  Created by Rodrigo Francischett Occhiuto on 20/10/24.
//

import Foundation

struct ResponseHandler {
    static func validateResponse(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}
