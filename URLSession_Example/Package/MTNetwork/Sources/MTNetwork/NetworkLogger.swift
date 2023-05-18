//
//  NetworkLogger.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/18.
//

import Foundation

public struct NetworkLogger {

    let configuration: Configuration

    public init(configuration: Configuration) {
        self.configuration = configuration
    }
}

extension NetworkLogger {
    public func willSend(_ urlRequest: URLRequest, _ request: Requestable) {

    }

    public func didReceive(_ result: Result<Response, MTError>, _ request: Requestable) {

    }
}

private extension NetworkLogger {
    func logNetworkRequest(_ urlRequest: URLRequest, _ request: Requestable, completion: @escaping ([String]) -> Void) {
        var output: [String] = []

        output.append(configuration.formatter.entry("Request", urlRequest.description, request))
    }
}

public extension NetworkLogger {
    struct Configuration {

        typealias OutputType = (_ request: Requestable, _ items: [String]) -> Void

        let formatter: Formatter
        let output: OutputType

        init(
            formatter: Formatter = Formatter(),
            output: @escaping OutputType = defaultOutput
        ) {
            self.formatter = formatter
            self.output = output
        }

        // MARK: - Default

        static func defaultOutput(request: Requestable, items: [String]) {
            for item in items {
                print(item, separator: ",", terminator: "\n")
            }
        }
    }
}

extension NetworkLogger.Configuration {
    struct Formatter {

        typealias DataFormatterType = (Data) -> (String)
        typealias EntryFormatterType = (_ identifier: String, _ message: String, _ request: Requestable) -> String

        let entry: EntryFormatterType
        let requestData: DataFormatterType
        var responseData: DataFormatterType

        init(
            entry: @escaping EntryFormatterType = defaultEntryFormatter,
            requestData: @escaping DataFormatterType = defaultDataFormatter,
            responseData: @escaping DataFormatterType = defaultDataFormatter
        ) {
            self.entry = entry
            self.requestData = requestData
            self.responseData = responseData
        }

        // MARK: - Defaults

        static func defaultDataFormatter(_ data: Data) -> String {
            return String(data: data, encoding: .utf8) ?? "⛔️ String으로 Data를 인코딩할 수 없습니다."
        }

        static func defaultEntryFormatter(identifier: String, message: String, request: Requestable) -> String {
            let date = defaultEntryDateFormatter.string(from: Date())
            return ">>> NetworkLogger: [\(date)]"
        }

        static var defaultEntryDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .short
            return formatter
        }()
    }
}
