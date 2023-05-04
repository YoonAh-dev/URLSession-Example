//
//  CollectionRequestDTO.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/04.
//

import Foundation

struct CollectionRequestDTO: Encodable {
    let title: String
    let description: String?
    let `private`: String

    init(title: String, description: String? = nil, `private`: Bool) {
        self.title = title
        self.description = description
        self.private = `private` ? "false" : "true"
    }
}
