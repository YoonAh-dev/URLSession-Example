//
//  Encodable+Extension.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
