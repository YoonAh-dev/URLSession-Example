//
//  PhotoRequest.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

import MTNetwork

enum PhotoRequest {
    case fetchImages(query: [String: Any])
}

extension PhotoRequest: Requestable {

    var baseURL: URL {
        return APIEnvironment.baseURL
    }

    var path: String {
        switch self {
        case .fetchImages:
            return "/photos"
        }
    }

    var method: MTNetwork.HTTPMethod {
        switch self {
        case .fetchImages:
            return .get
        }
    }

    var task: MTNetwork.HTTPTask {
        switch self {
        case let .fetchImages(query):
            return .requestParameters(query)
        }
    }

    var headers: MTNetwork.HTTPHeaders {
        switch self {
        case .fetchImages:
            let token = "\(KeyProvider.appKey(of: .clientId))"
            let authorization = HTTPHeader.authorization(token)
            return HTTPHeaders([authorization])
        }
    }

    var requestTimeout: Float {
        return 20
    }

    var sampleData: Data? {
        return Data()
    }

}
