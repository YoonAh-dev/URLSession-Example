//
//  Provider.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

public struct Provider<T: Requestable>: Providable {

    public init() { }

    public mutating func request(_ request: T) async throws -> Response {

        let endpoint = self.endpoint(request)
        let urlRequest = try endpoint.urlRequest()

        self.willSend(urlRequest, request)

        let session = self.defaultSession(timeout: request.requestTimeout)

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw MTError.invalidResponse
        }

        let responseData = self.response(data, response: httpResponse)

        switch httpResponse.statusCode {
        case (200..<300):
            self.didReceive(.success(responseData), request)
            return responseData
        case (300..<400):
            let error = MTError.statusCode(reason: .noRedirect(responseData))
            self.didReceive(.failure(error), request)
            throw error
        case (400..<500):
            let error = MTError.statusCode(reason: .clientError(responseData))
            self.didReceive(.failure(error), request)
            throw error
        case (500..<600):
            let error = MTError.statusCode(reason: .serverError(responseData))
            self.didReceive(.failure(error), request)
            throw error
        default:
            let error = MTError.statusCode(reason: .invalidStatus(responseData))
            self.didReceive(.failure(error), request)
            throw error
        }
    }
}

extension Provider {
    fileprivate func endpoint(_ request: Requestable) -> EndPoint {
        return EndPoint(url: URL(request: request).absoluteString,
                        method: request.method,
                        task: request.task,
                        httpHeaderFields: request.headers)
    }

    fileprivate func defaultSession(timeout: Float) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        configuration.timeoutIntervalForResource = TimeInterval(timeout)

        return URLSession(configuration: configuration)
    }

    fileprivate func response(_ data: Data, response: HTTPURLResponse) -> Response {
        let statusCode = response.statusCode
        return Response(statusCode: statusCode,
                        response: response,
                        data: data)
    }
}

extension Provider {

    // MARK: - Private - Logger

    private func willSend(_ urlRequest: URLRequest, _ request: Requestable) {
        NetworkLogger().willSend(urlRequest, request)
    }

    private func didReceive(_ result: Result<Response, MTError>, _ request: Requestable) {
        switch result {
        case .success(let success):
            NetworkLogger().didReceive(.success(success), request)
        case .failure(let failure):
            NetworkLogger().didReceive(.failure(failure), request)
        }
    }
}
