//
//  MultipartFormData.swift
//  
//
//  Created by SHIN YOON AH on 2023/05/18.
//

import Foundation

public struct MultipartFormData {

    public enum FormDataProvider {
        case data(Data)
    }

    /// The method being used for providing form data.
    public let provider: FormDataProvider

    /// The name.
    public let name: String

    /// The file name.
    public let filename: String?

    /// The MIME type
    public let mimeType: String?

    public init(
        provider: FormDataProvider,
        name: String,
        filename: String? = nil,
        mimeType: String? = nil
    ) {
        self.provider = provider
        self.name = name
        self.filename = filename
        self.mimeType = mimeType
    }
}
