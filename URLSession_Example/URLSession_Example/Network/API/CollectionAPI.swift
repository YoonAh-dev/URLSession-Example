//
//  CollectionAPI.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/18.
//

import Foundation

import MTNetwork

protocol CollectionAPIProtocol {
    func fetchCollections() async -> Result<[CollectionResponse], Error>
    func uploadCollection(collection: Collection) async -> Result<[CollectionResponse], Error>
}

final class CollectionAPI: CollectionAPIProtocol {

    private var provider = Provider<CollectionRequest>()

    func fetchCollections() async -> Result<[CollectionResponse], Error> {
        do {
            let response = try await self.provider.request(.fetchCollections)
            let decodingResponse: [CollectionResponse] = try response.decode()
            return .success(decodingResponse)
        } catch {
            return .failure(error)
        }
    }

    func uploadCollection(collection: Collection) async -> Result<[CollectionResponse], Error> {
        do {
            let response = try await self.provider.request(.uploadCollection(collection: collection))
            let decodingResponse: [CollectionResponse] = try response.decode()
            return .success(decodingResponse)
        } catch {
            return .failure(error)
        }
    }
}
