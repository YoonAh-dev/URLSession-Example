//
//  MTError.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

public enum MTError: Error {
    ///  failed to create a valid `URL`.
    case invalidURL(error: Error)

    ///  failed to encode multipart form data.
    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)

    ///  failed to encode parameter.
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)

    ///  failed to decode response.
    case responseDecodingFailed(error: Error)

    ///  response failed with an invalid HTTP status code.
    case statusCodeFailed(reason: StatusCodeFailureReason)

    public enum MultipartEncodingFailureReason {

    }

    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailure(error: Error)
    }

    public enum StatusCodeFailureReason {
        case noRedirect
        case serverError
        case invalidStatus
    }
}

extension MTError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let error):
            return "⛔️ 유효하지 않은 URL 입니다. URL를 확인해주세요.\n" + "⛔️ error: \(error.localizedDescription)"
        case .multipartEncodingFailed(let reason):
            return reason.errorDescription
        case .parameterEncodingFailed(let reason):
            return reason.errorDescription
        case .responseDecodingFailed(let error):
            return "⛔️ response를 decode할 수 없습니다.\n" + "⛔️ error: \(error.localizedDescription)"
        case .statusCodeFailed(let reason):
            return reason.errorDescription
        }
    }
}

extension MTError.MultipartEncodingFailureReason: LocalizedError {
    public var errorDescription: String? {
        return nil
    }
}

extension MTError.ParameterEncodingFailureReason: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingURL:
            return "⛔️ missing URL로 URLRequest가 encode 되었습니다."
        case .jsonEncodingFailure(let error):
            return "⛔️ JSON 형식으로 encode할 수 없습니다.\n" + "⛔️ error: \(error.localizedDescription)"
        }
    }
}

extension MTError.StatusCodeFailureReason: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noRedirect:
            return "⛔️ 300..<400 코드가 들어왔습니다."
        case .serverError:
            return "⛔️ server에서 문제가 발생했습니다."
        case .invalidStatus:
            return "⛔️ 유효하지 않은 상태 코드가 들어왔습니다."
        }
    }
}
