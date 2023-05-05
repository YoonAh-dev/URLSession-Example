//
//  APIRequest.swift
//  URLSession_Example
//
//  Created by SHIN YOON AH on 2023/05/05.
//

import Foundation

struct APIRequest {

    typealias Response = (data: Data, response: URLResponse)

    func request<T: Decodable>(_ request: NetworkRequest) async throws -> (statusCode: Int, data: T?) {
        let responseData = try await self.requestDataToURL(request)

        guard let httpResponse = responseData.response as? HTTPURLResponse else {
            throw NetworkError.serverError
        }

        switch httpResponse.statusCode {
        case (200..<300):
            do {
                let decoder = JSONDecoder()
                let baseModelData: T? = try decoder.decode(T.self, from: responseData.data)
                return (httpResponse.statusCode, baseModelData)
            } catch {
                throw NetworkError.decodingError
            }
        case (300..<500):
            throw NetworkError.clientError(message: httpResponse.statusCode.description)
        default:
            throw NetworkError.serverError
        }
    }

    private func requestDataToURL(_ request: NetworkRequest) async throws -> Response {
        let urlRequest = request.buildURLRequest()
        let sessionConfiguration = request.buildURLSessionConfiguration()
        let session = URLSession(configuration: sessionConfiguration)
        return try await session.data(for: urlRequest)
    }
}
