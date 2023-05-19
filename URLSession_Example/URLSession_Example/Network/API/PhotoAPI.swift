//
//  PhotoAPI.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

import MTNetwork

protocol PhotoAPIProtocol {
    func fetchImages(perPage: Int, orderBy: String) async -> Result<[Image], Error>
}

final class PhotoAPI: PhotoAPIProtocol {

    private var provider = Provider<PhotoRequest>()

    func fetchImages(perPage: Int, orderBy: String) async -> Result<[Image], Error> {
        do {
            let queryParameter = [
                "per_page": perPage.description,
                "order_by": orderBy
            ]
            let response = try await self.provider.request(.fetchImages(query: queryParameter), didMeasureTime: true)
            let decodingResponse: [Image] = try response.decode()

            return .success(decodingResponse)
        } catch {
            return .failure(error)
        }
    }
}
