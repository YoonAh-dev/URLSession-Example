//
//  CollectionRequest.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

import MTNetwork

enum CollectionRequest {
    case fetchCollections
    case uploadCollection(collection: Collection)
}

extension CollectionRequest: Requestable {

    var baseURL: URL {
        return APIEnvironment.baseURL
    }

    var path: String {
        switch self {
        case .fetchCollections,
             .uploadCollection:
            return "/collections"
        }
    }

    var method: MTNetwork.HTTPMethod {
        switch self {
        case .fetchCollections:
            return .get
        case .uploadCollection:
            return .post
        }
    }

    var task: MTNetwork.HTTPTask {
        switch self {
        case .fetchCollections:
            return .requestPlain
        case let .uploadCollection(collection):
            return .requestJSONEncodable(collection)
        }
    }

    var headers: [String : String] {
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

    var requestTimeout: Float {
        return 20
    }

    var sampleData: Data? {
        return Data()
    }

}
