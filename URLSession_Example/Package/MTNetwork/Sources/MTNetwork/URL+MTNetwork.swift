//
//  URL+MTNetwork.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

public extension URL {
    init<T: Requestable>(request: T) {
        let path = request.path
        if path.isEmpty {
            self = request.baseURL
        } else {
            let tag = request.baseURL.absoluteString.hasSuffix("/") ? "" : "/"
            self = .init(string: request.baseURL.absoluteString + tag + path)!
        }
    }
}
