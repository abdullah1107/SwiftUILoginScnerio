//
//  LoginService.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 20/11/23.
//

import Foundation
import Combine


protocol APIRequestConfiguration {
//    /// Base endpoint path.
//    var basePath: String { get }
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

public enum LoginAPI{
    case postLoginRequest(username: String, password: String)
    case getLoginResponse
}

extension LoginAPI: APIRequestConfiguration{
    
    typealias ReturnType = LoginUserResponse
    
    var method: HTTPMethod {
        return .post
    }
    
    var contentType: String {
        return "application/json"
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var queryParams: [String : Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }

    public var path: String {
        switch self{
        case .postLoginRequest:
            return "auth/login"
        case .getLoginResponse:
            return "auth/login"
        }
    }
    
}


extension APIRequestConfiguration{
   
    var method: HTTPMethod { return .get }
    var contentType: String { return "application/json" }
    var queryParams: [String: Any]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
    
    
    
    /// requestBody with HTTP
    private func encodeToJson<T: Encodable>(object: T) -> Data? {
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
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
    
    func addQueryItems(queryParams: [String: Any]?) -> [URLQueryItem]? {
        guard let queryParams = queryParams else {
            return nil
        }
        return queryParams.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
    }
    
    /// Transforms an Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        urlComponents.queryItems = addQueryItems(queryParams: queryParams)
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        
        ///Set your Common Headers here
        ///Like: api secret key for authorization header
        ///Or set your content type
        //request.setValue("Your API Token key", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
      
        return request
    }
}
