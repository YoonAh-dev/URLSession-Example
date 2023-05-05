//
//  CollectionEndPoint.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

enum CollectionEndPoint {
    case fetchCollections
    case uploadCollection(collection: CollectionRequestDTO)
}

extension CollectionEndPoint: EndPointable {
    var requestTimeOut: Float {
        return 20
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .fetchCollections:
            return .GET
        case .uploadCollection:
            return .POST
        }
    }

    var data: HTTPTask {
        switch self {
        case .fetchCollections:
            return .requestPlain
        case .uploadCollection(let collection):
            return .requestBody(bodyData: collection.encode())
        }
    }

    var path: String {
        switch self {
        case .fetchCollections,
             .uploadCollection:
            return "/collections"
        }
    }

    var header: [String : String]? {
        switch self {
        case .fetchCollections:
            return ["Authorization": "\(KeyProvider.appKey(of: .clientId))"]
        case .uploadCollection:
            return [
                "Authorization": "\(KeyProvider.appKey(of: .accessToken))",
                "Content-Type": "application/json"
            ]
        }
    }
}

