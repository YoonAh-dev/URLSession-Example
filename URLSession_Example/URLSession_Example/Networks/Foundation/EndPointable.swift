//
//  EndPointable.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

protocol EndPointable {
    var requestTimeOut: Double { get }
    var httpMethod: HTTPMethod { get }
    var data: HTTPTask { get }
    var path: String { get }
    var header: [String: String]? { get }
}

extension EndPointable {
    func buildRequest() -> NetworkRequest {
        let url = APIEnvironment.url + self.path
        return NetworkRequest(requestTimeout: self.requestTimeOut,
                              httpMethod: self.httpMethod.rawValue,
                              data: self.data,
                              url: url,
                              header: self.header)
    }
}
