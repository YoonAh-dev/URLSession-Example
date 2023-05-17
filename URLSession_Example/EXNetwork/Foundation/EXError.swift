//
//  EXError.swift
//  EXNetwork
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

enum EXError: Error {
    case invalidURL
    case multipartEncodingFailed
    case parameterEncodingFailed
    case responseDecodingFailed
    case statusCodeFailed

    enum multipartEncodingFailureReason {

    }

    enum parameterEncodingFailureReason {
        
    }
}
