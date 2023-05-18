//
//  PhotoService.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

import MTNetwork

protocol PhotoServiceProtocol {
    func fetchImages(perPage: Int, orderBy: String) async throws -> [Image]?
}

final class PhotoService: PhotoServiceProtocol {

    private var photoAPI = PhotoAPI()

    func fetchImages(perPage: Int, orderBy: String) async throws -> [Image]? {
        let response = try await self.photoAPI.fetchImages(perPage: perPage, orderBy: orderBy)
        return try response.decode()
    }
}
