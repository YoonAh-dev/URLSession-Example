//
//  CollectionService.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/18.
//

import Foundation

import MTNetwork

protocol CollectionServiceProtocol {
    mutating func fetchCollections() async throws -> [CollectionResponseDTO]?
}

final class CollectionService: CollectionServiceProtocol {

    private var collectionAPI = CollectionAPI()

    func fetchCollections() async throws -> [CollectionResponseDTO]? {
        let response = try await self.collectionAPI.fetchCollections()
        return try response.decode()
    }
}
