//
//  CollectionResponse.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/04.
//

import Foundation

struct CollectionResponse: Decodable {
    let id, title, description: String?
    let publishedAt: String?
    let lastCollectedAt: String?
    let updatedAt: String?
    let curated, featured: Bool?
    let totalPhotos: Int?
    let collectionDTOPrivate: Bool?
    let shareKey: String?
    let tags: [Tag]?
    let links: CollectionDTOLinks?
    let user: User?
    let coverPhoto: CollectionDTOCoverPhoto?
    let previewPhotos: [PreviewPhoto]?

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

struct CoverPhotoLinks: Decodable {
    let linksSelf, html, download, downloadLocation, photos: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
        case photos
    }
}

struct CollectionDTOCoverPhoto: Decodable {
    let id: String?
    let createdAt, updatedAt: String?
    let promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls?
    let links: CoverPhotoLinks?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [String]?
    let sponsorship: String?
    let topicSubmissions: PurpleTopicSubmissions?
    let user: User?
    let slug: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls, links, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship
        case topicSubmissions = "topic_submissions"
        case user, slug
    }
}

struct PurpleTopicSubmissions: Decodable {
    let artsCulture, businessWork, architectureInterior, interiors: ArchitectureInterior?

    enum CodingKeys: String, CodingKey {
        case artsCulture = "arts-culture"
        case businessWork = "business-work"
        case architectureInterior = "architecture-interior"
        case interiors
    }
}

struct ArchitectureInterior: Decodable {
    let status: String?
    let approvedOn: String?

    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}

struct CollectionDTOLinks: Decodable {
    let linksSelf, html, photos, related: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, related
    }
}

struct PreviewPhoto: Decodable {
    let id, slug: String?
    let createdAt, updatedAt: String?
    let blurHash: String?
    let urls: Urls?

    enum CodingKeys: String, CodingKey {
        case id, slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case urls
    }
}

struct Tag: Decodable {
    let type: String?
    let title: String?
    let source: Source?
}

struct Source: Decodable {
    let ancestry: Ancestry?
    let title, subtitle, description, metaTitle: String?
    let metaDescription: String?
    let coverPhoto: SourceCoverPhoto?

    enum CodingKeys: String, CodingKey {
        case ancestry, title, subtitle, description
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case coverPhoto = "cover_photo"
    }
}

struct Ancestry: Decodable {
    let type: Category?
    let category, subcategory: Category?
}

struct Category: Decodable {
    let slug, prettySlug: String?

    enum CodingKeys: String, CodingKey {
        case slug
        case prettySlug = "pretty_slug"
    }
}

struct SourceCoverPhoto: Decodable {
    let id: String?
    let createdAt, updatedAt: String?
    let promotedAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let description, altDescription: String?
    let urls: Urls?
    let links: CoverPhotoLinks?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [String]?
    let sponsorship: String?
    let topicSubmissions: FluffyTopicSubmissions?
    let premium, plus: Bool?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case urls, links, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship
        case topicSubmissions = "topic_submissions"
        case premium, plus, user
    }
}

struct FluffyTopicSubmissions: Decodable {
    let health, athletics, people, nature: ArchitectureInterior?
    let wallpapers, architectureInterior, colorOfWater, texturesPatterns: ArchitectureInterior?
    let currentEvents, spirituality, artsCulture: ArchitectureInterior?

    enum CodingKeys: String, CodingKey {
        case health, athletics, people, nature, wallpapers
        case architectureInterior = "architecture-interior"
        case colorOfWater = "color-of-water"
        case texturesPatterns = "textures-patterns"
        case currentEvents = "current-events"
        case spirituality
        case artsCulture = "arts-culture"
    }
}
