//
//  APIRequestProtocol.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 25/11/23.
//

import Foundation

protocol APIRequestConfiguration {
    /// Base endpoint path.
    //var basePath: String { get }
    
    /// Complete path for an endpoint.
    var path: String { get }
    
    /// get method
    var method: HTTPMethod { get }
    
    /// get contrentType
    var contentType: String { get }
    
    /// body of the request paream
    var body: [String: Any]? { get }
    
    /// query parameter for request param
    var queryParams: [String: Any]? { get }
    
    /// header of the request param
    var headers: [String: String]? { get }
    
    /// return type of each request
    associatedtype ReturnType: Codable

}


extension APIRequestConfiguration{
    
    /// requestBody with HTTP
    public func encodeToJson<T: Encodable>(object: T) -> Data? {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(object)
            return jsonData
        } catch {
            print("Error encoding object to JSON: \(error)")
            return nil
        }
    }
    
    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    public func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
    
    
    public func addQueryItems(queryParams: [String: Any]?) -> [URLQueryItem]? {
        guard let queryParams = queryParams else {
            return nil
        }
        return queryParams.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
    }
    
    public func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    public func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}

//// Extending Encodable to Serialize a Type into a Dictionary
extension Encodable {
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }

        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
