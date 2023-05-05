//
//  PhotoAPI.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

protocol PhotoProtocol {
    func fetchImages(perPage: Int, orderBy: String) async throws -> (statusCode: Int, data: [Image]?)
}

struct PhotoAPI: PhotoProtocol {
    func fetchImages(perPage: Int, orderBy: String) async throws -> (statusCode: Int, data: [Image]?) {
        let queryParameter = [
            "per_page": perPage.description,
            "order_by": orderBy
        ]
        let request = PhotoEndPoint
            .fetchImages(query: queryParameter)
            .buildRequest()
        return try await APIRequest().request(request)
    }
}
