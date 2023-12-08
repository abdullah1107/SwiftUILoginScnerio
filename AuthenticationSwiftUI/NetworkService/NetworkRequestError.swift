//
//  NetworkRequestError.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 19/11/23.
//

import Foundation

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError( _ description: String)
    case urlSessionFailed(_ error: URLError)
    case timeOut
    case unknownError
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed
    case encodeFailed
    case decodeFailed
    case timeOut
    case unknownError
}
