//
//  KeyProvider.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

struct KeyProvider {

    enum KeyType: String {
        case clientId
        case accessToken
        case username
    }

    // MARK: - func

    static func appKey(of type: KeyType) -> String {
        var keys: NSDictionary?

        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }

        if let dict = keys,
           let appKey = dict[type.rawValue] as? String {
            return appKey
        }

        return ""
    }
}
