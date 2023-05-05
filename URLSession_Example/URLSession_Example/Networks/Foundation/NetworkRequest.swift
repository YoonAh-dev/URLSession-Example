//
//  NetworkRequest.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

struct NetworkRequest {
    var url: URL
    let header: [String: String]?
    var body: Data?
    let requestTimeOut: Double
    let httpMethod: String

    init(requestTimeout: Double,
         httpMethod: String,
         data: HTTPTask,
         url: String,
         header: [String: String]? = nil
    ) {
        self.requestTimeOut = requestTimeout
        self.httpMethod = httpMethod
        self.url = URL(string: url)!
        self.header = header
        self.handleHTTPTask(data)
    }

    func buildURLRequest() -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = body
        return urlRequest
    }

    func buildURLSessionConfiguration() -> URLSessionConfiguration {
        var urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.timeoutIntervalForRequest = TimeInterval(floatLiteral: self.requestTimeOut)
        return urlSessionConfiguration
    }
}

extension NetworkRequest {
    private mutating func handleHTTPTask(_ task: HTTPTask) {
        switch task {
        case .requestPlain:
            break
        case .requestBody(let bodyData):
            self.body = bodyData
        case .requestQueryParameter(let parameter):
            let queryItem = self.buildQueryItem(parameter)
            self.url.append(queryItems: queryItem)
        }
    }

    private func buildQueryItem(_ parameter: [String: String]) -> [URLQueryItem] {
        return parameter.compactMap { URLQueryItem(name: $0, value: $1) }
    }
}
