//
//  EndPoint.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

public struct EndPoint {

    /// A string representation of the URL for the request.
    let url: String

    /// The HTTP method for the request.
    let method: HTTPMethod

    /// The `Task` for the request.
    let task: HTTPTask

    /// The HTTP header fields for the request.
    let httpHeaderFields: [String: String]?

    public init(
        url: String,
        method: HTTPMethod,
        task: HTTPTask,
        httpHeaderFields: [String : String]?
    ) {
        self.url = url
        self.method = method
        self.task = task
        self.httpHeaderFields = httpHeaderFields
    }
}

public extension EndPoint {
    
    /// Returns the `Endpoint` converted to a `URLRequest` if valid. Throws an error otherwise.
    func urlRequest() throws -> URLRequest {
        guard let url = URL(string: self.url) else {
            let error = NSError(domain: "\(#file) :: \(#function) :: \(#line)", code: 404)
            throw MTError.invalidURL(error: error)
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = self.httpHeaderFields

        switch task {
        case .requestPlain:
            return request
        case let .requestJSONEncodable(encodable):
            return try request.encode(encodable: encodable)
        case let .requestParameters(parameters):
            return try request.encode(parameters: parameters)
        case let .requestCompositeParameters(body, query):
            var bodyfulRequest = try request.encode(encodable: body)
            return try bodyfulRequest.encode(parameters: query)
        case .uploadMultipart:
            return request
        case let .uploadCompositeMultipart(_, query):
            return try request.encode(parameters: query)
        }
    }
}
