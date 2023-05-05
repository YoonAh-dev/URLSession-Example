//
//  HTTPTask.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

enum HTTPTask {
    case requestPlain
    case requestBody(bodyData: Data?)
    case requestQueryParameter(parameter: [String: String])
}
