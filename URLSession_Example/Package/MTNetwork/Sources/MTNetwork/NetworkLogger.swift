//
//  NetworkLogger.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/18.
//

import Foundation

public struct NetworkLogger {

    let configuration: Configuration

    public init(configuration: Configuration = Configuration()) {
        self.configuration = configuration
    }
}

extension NetworkLogger {
    public func willSend(_ urlRequest: URLRequest, _ request: Requestable) {
        self.logNetworkRequest(urlRequest, request) { output in
            self.configuration.output(request, output)
        }
    }

    public func didReceive(_ result: Result<Response, MTError>, _ request: Requestable) {

    }
}

private extension NetworkLogger {
    func logNetworkRequest(_ urlRequest: URLRequest, _ request: Requestable, completion: @escaping ([String]) -> Void) {
        var output: [String] = []

        output.append(self.configuration.formatter.entry("Request", urlRequest.description, request))

        var allHeaders: [String: String] = [:]
        if let headerFields = urlRequest.allHTTPHeaderFields {
            allHeaders.merge(headerFields) { $1 }
        }
        output.append(self.configuration.formatter.entry("Request Headers", allHeaders.description, request))

        if let bodyStreams = urlRequest.httpBodyStream {
            output.append(self.configuration.formatter.entry("Request BodyStreams", bodyStreams.description, request))
        }

        if let body = urlRequest.httpBody {
            output.append(self.configuration.formatter.entry("Request Body", body.description, request))
        }

        if let method = urlRequest.httpMethod {
            output.append(self.configuration.formatter.entry("HTTP Request Method", method, request))
        }

        completion(output)
    }
}

public extension NetworkLogger {
    struct Configuration {

        public typealias OutputType = (_ request: Requestable, _ items: [String]) -> Void

        public let formatter: Formatter
        public let output: OutputType

        public init(
            formatter: Formatter = Formatter(),
            output: @escaping OutputType = defaultOutput
        ) {
            self.formatter = formatter
            self.output = output
        }

        // MARK: - Default

        public static func defaultOutput(request: Requestable, items: [String]) {
            for item in items {
                print(item, separator: ",", terminator: "\n")
            }
        }
    }
}

extension NetworkLogger.Configuration {
    public struct Formatter {

        public typealias DataFormatterType = (Data) -> (String)
        public typealias EntryFormatterType = (_ identifier: String, _ message: String, _ request: Requestable) -> String

        private static let divider = "==============================\n"
        private static let dateFormatString = "dd/MM/yyyy HH:mm:ss"

        public let entry: EntryFormatterType
        public let requestData: DataFormatterType
        public var responseData: DataFormatterType

        public init(
            entry: @escaping EntryFormatterType = defaultEntryFormatter,
            requestData: @escaping DataFormatterType = defaultDataFormatter,
            responseData: @escaping DataFormatterType = defaultDataFormatter
        ) {
            self.entry = entry
            self.requestData = requestData
            self.responseData = responseData
        }

        // MARK: - Defaults

        public static func defaultDataFormatter(_ data: Data) -> String {
            return String(data: data, encoding: .utf8) ?? "⛔️ String으로 Data를 인코딩할 수 없습니다."
        }

        public static func defaultEntryFormatter(identifier: String, message: String, request: Requestable) -> String {
            let date = defaultEntryDateFormatter.string(from: Date())
            return divider + "MTNetwork_Logger: [\(date)]\n> \(identifier): \(message)"
        }

        public static var defaultEntryDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormatString
            return formatter
        }()
    }
}
