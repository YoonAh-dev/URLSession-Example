//
//  Response.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/17.
//

import Foundation

public struct Response {

    /// The status code of the response.
    public let statusCode: Int

    /// The HTTPURLResponse object.
    public let response: HTTPURLResponse?

    /// The response data.
    public let data: Data

    /// A text description of the `Response`.
    public var description: String {
        return "Status Code: \(self.statusCode), Data Length: \(self.data.count)"
    }

}

public extension Response {
    func decode<T: Decodable>() throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)

            let response = try decoder.decode(T.self, from: self.data)
            return response
        } catch {
            throw MTError.responseDecodingFailed(self)
        }
    }
}
