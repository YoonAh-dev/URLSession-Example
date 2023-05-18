//
//  MultipartRequest.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/18.
//

import Foundation

import MTNetwork

enum MultipartRequest {
    case fetchCollections
}

extension MultipartRequest: Requestable {

    var baseURL: URL {
        return BaseURL(host: "dev.aenitto.shop", version: .v1).default
    }

    var path: String {
        switch self {
        case .fetchCollections:
            return "/rooms/255/messages-separate"
        }
    }

    var method: MTNetwork.HTTPMethod {
        switch self {
        case .fetchCollections:
            return .post
        }
    }

    var task: MTNetwork.HTTPTask {
        switch self {
        case .fetchCollections:
            var data: [MultipartFormData] = []
            let parameters: [String: Any] = ["manitteeId": "85942b7d-5589-48f7-b5a4-be799d3d29c6",
                                             "messageContent": "테스트 성공한 거 같아요~!~!",
                                             "missionId": "17"]
            let parameter = MultipartFormData(provider: .parameter(parameters))
            data.append(parameter)

            return .uploadMultipart(data)
        }
    }

    var headers: [String : String] {
        switch self {
        case .fetchCollections:
            return [
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIwMDA5MzYuMzc2NDNmNGFmODE4NGE0MzhiYTRjODgwNzEzMDI1NDAuMTAxNyIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNjg0NDAxMzY2LCJleHAiOjE3MTU1MDUzNjZ9.4VXqc7vvBmZQv_vl3u0P8KkRGl5Yyf0ErbU7cW3WE2k"
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

final class sampleAPI {

    private var provider = Provider<MultipartRequest>()

    func fetchImages() {
        Task {
            do {
                let response = try await self.provider.request(.fetchCollections)
                dump(response)
            } catch {
                dump(error)
            }
        }
    }
}
