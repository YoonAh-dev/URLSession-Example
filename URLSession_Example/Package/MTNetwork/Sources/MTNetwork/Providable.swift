//
//  Providable.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

public protocol Providable {
    mutating func request(_ request: Requestable) async throws -> Response
}
