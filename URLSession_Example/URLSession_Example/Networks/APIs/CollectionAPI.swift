//
//  CollectionAPI.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

protocol CollectionProtocol {
    func fetchCollections() async throws -> (statusCode: Int, data: [CollectionResponseDTO]?)
    func uploadCollection(collection: CollectionRequestDTO) async throws -> (statusCode: Int, data: [CollectionResponseDTO]?)
}

struct CollectionAPI: CollectionProtocol {
    func fetchCollections() async throws -> (statusCode: Int, data: [CollectionResponseDTO]?) {
        let request = CollectionEndPoint
            .fetchCollections
            .buildRequest()
        return try await APIRequest().request(request)
    }

    func uploadCollection(collection: CollectionRequestDTO) async throws -> (statusCode: Int, data: [CollectionResponseDTO]?) {
        let request = CollectionEndPoint
            .uploadCollection(collection: collection)
            .buildRequest()
        return try await APIRequest().request(request)
    }
}
