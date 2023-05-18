//
//  CollectionAPI.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/18.
//

import Foundation

import MTNetwork

protocol CollectionAPIProtocol {
    mutating func fetchCollections() async throws -> Response
    mutating func uploadCollection(collection: CollectionRequestDTO) async throws -> Response
}

struct CollectionAPI: CollectionAPIProtocol {

    private var provider = Provider<CollectionRequest>()

    mutating func fetchCollections() async throws -> Response {
        return try await self.provider.request(.fetchCollections)
    }

    mutating func uploadCollection(collection: CollectionRequestDTO) async throws -> Response {
        return try await self.provider.request(.uploadCollection(collection: collection))
    }
}
