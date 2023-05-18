//
//  BaseURL.swift
//  URLSession_Network
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

struct BaseURL {

    enum Version {
        case v1
        case v2
        case none

        var path: String? {
            switch self {
            case .v1: return "/api/v1"
            case .v2: return "/api/v2"
            case .none: return nil
            }
        }
    }

    // MARK: - property

    let `default`: URL

    // MARK: - init

    init(
        scheme: String = "https://",
        host: String,
        version: Version = .none
    ) {
        if let path = version.path {
            self.default = URL(string: scheme + host + path)!
        } else {
            self.default = URL(string: scheme + host)!
        }
    }

}
