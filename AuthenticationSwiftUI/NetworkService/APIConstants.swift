//
//  APIConstants.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 19/11/23.
//

import Foundation

final class APIConstants {
    static var basedURL: String = "https://dummyjson.com"
}

enum HTTPHeaderField: String {
    case authentication = "Authentication"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
    case acceptLanguage = "Accept-Language"
    case userAgent = "User-Agent"
}

enum ContentType: String {
    case json = "application/json"
    case xwwwformurlencoded = "application/x-www-form-urlencoded"
}
