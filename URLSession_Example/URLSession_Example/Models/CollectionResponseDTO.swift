//
//  CollectionResponseDTO.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/04.
//

import Foundation

struct CollectionResponseDTO: Codable {
    let id, title, description: String?
    let publishedAt: String?
    let lastCollectedAt: String?
    let updatedAt: String?
    let curated, featured: Bool?
    let totalPhotos: Int?
    let collectionDTOPrivate: Bool?
    let shareKey: String?
    let tags: [String]?
    let links: Links
    let user: User?
    let coverPhoto, previewPhotos: String?

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case curated, featured
        case totalPhotos = "total_photos"
        case collectionDTOPrivate = "private"
        case shareKey = "share_key"
        case tags, links, user
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
    }
}

struct Links: Codable {
    let linksSelf, html, photos: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos
    }
}
