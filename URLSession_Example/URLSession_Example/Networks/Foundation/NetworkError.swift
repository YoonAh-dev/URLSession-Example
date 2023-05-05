//
//  NetworkError.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case clientError(message: String?)
    case serverError
    case unknownError
}
