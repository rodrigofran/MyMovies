//
//  RequestBuilder.swift
//  NetworkKit
//
//  Created by Rodrigo Francischett Occhiuto on 20/10/24.
//

import Foundation

struct RequestBuilder {
    static func buildRequest(for apiRequest: APIRequestProtocol) throws -> URLRequest {
        guard let url = URL(string: apiRequest.fullURL) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.rawValue
        
        if let headers = apiRequest.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = apiRequest.body {
            request.httpBody = body
        }
        
        return request
    }
}
