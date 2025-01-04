//
//  APIRequest.swift
//  NetworkKit
//
//  Created by Rodrigo Francischett Occhiuto on 20/10/24.
//

import Foundation

public typealias EntrySet = (key: Any, value: Any)

public protocol APIRequestProtocol {
    var baseURL: String { get }
    var queryParameters: [(key: String, value: String)]? { get }
    var method: HttpMethod { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    var fullURL: String { get }
}

public struct APIRequest: APIRequestProtocol {
    public let baseURL: String
    public var queryParameters: [(key: String, value: String)]?
    public var paths: [Any] = []
    public let method: HttpMethod
    public let body: Data?
    
    public var headers: [String: String]?
    
    public init(
        baseURL: String,
        queryParameters: [EntrySet]? = nil,
        paths: [Any] = [],
        method: HttpMethod,
        body: Data? = nil,
        headers: [String: String]? = nil
    ) {
        self.baseURL = baseURL
        self.queryParameters = queryParameters?.map { (key: "\($0.key)", value: "\($0.value)") }
        self.paths = paths.map { "\($0)"}
        self.method = method
        self.body = body
        
        var defaultHeaders: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiODU3MjhhMjJlMGQ4ODQyOGIzMzY4NGE5NjhiMDQ5ZSIsIm5iZiI6MTczMjg0MzYwMy42NDA5MTY2LCJzdWIiOiI2NzQ3N2RjMjMzMzhkZmM5Mjg0NGQyYjYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.VVb3Fxo38wYbHSYMB59tH-xE19VxZJ4yn7HfnkobO4Y"
        ]
        
        if let userHeaders = headers {
            for (key, value) in userHeaders {
                defaultHeaders[key] = value
            }
        }
        
        self.headers = defaultHeaders
    }
    
    public var fullURL: String {
        var components = URLComponents()
        
        components.scheme = URL(string: baseURL)?.scheme
        components.host = URL(string: baseURL)?.host
        
        if !paths.isEmpty {
            let pathString = paths.compactMap { $0 as? String }.joined(separator: "/")
            components.path = "/" + pathString
        }
        
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            components.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        return components.url?.absoluteString ?? ""
    }
}

public enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

