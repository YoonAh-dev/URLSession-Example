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

    var headers: MTNetwork.HTTPHeaders {
        switch self {
        case .fetchCollections:
            let token = "\(KeyProvider.appKey(of: .clientId))"
            let authorization = HTTPHeader.authorization(token)
            return HTTPHeaders([authorization])
        case .uploadCollection:
            let token = "\(KeyProvider.appKey(of: .accessToken))"
            let authorization = HTTPHeader.authorization(bearerToken: token)
            let contentType = HTTPHeader.contentType("application/json")
            return HTTPHeaders([authorization, contentType])
        }
    }

    var requestTimeout: Float {
        return 20
    }

    var sampleData: Data? {
        return Data()
    }

}
