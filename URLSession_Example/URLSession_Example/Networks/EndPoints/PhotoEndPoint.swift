//
//  PhotoEndPoint.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

enum PhotoEndPoint {
    case fetchImages(query: [String: String])
}

extension PhotoEndPoint: EndPointable {
    var requestTimeOut: Float {
        return 20
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .fetchImages:
            return .GET
        }
    }

    var data: HTTPTask {
        switch self {
        case .fetchImages(let query):
            return .requestQueryParameter(parameter: query)
        }
    }

    var path: String {
        switch self {
        case .fetchImages:
            return "/photos"
        }
    }

    var header: [String : String]? {
        switch self {
        case .fetchImages:
            return ["Authorization": "\(KeyProvider.appKey(of: .clientId))"]
        }
    }
}
