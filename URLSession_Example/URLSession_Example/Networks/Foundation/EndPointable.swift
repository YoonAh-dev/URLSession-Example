//
//  EndPointable.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

protocol EndPointable {
    var requestTimeOut: Float { get }
    var httpMethod: HTTPMethod { get }
    var data: HTTPTask { get }
    var path: String { get }
    var header: [String: String]? { get }
}
