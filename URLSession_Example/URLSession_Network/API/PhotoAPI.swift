//
//  PhotoAPI.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

import MTNetwork

protocol PhotoAPIProtocol {
    mutating func fetchImages(perPage: Int, orderBy: String) async throws -> Response
}

struct PhotoAPI: PhotoAPIProtocol {

    private var provider = Provider<PhotoRequest>()

    mutating func fetchImages(perPage: Int, orderBy: String) async throws -> Response {
        let queryParameter = [
            "per_page": perPage.description,
            "order_by": orderBy
        ]

        return try await self.provider.request(.fetchImages(query: queryParameter))
    }
}
