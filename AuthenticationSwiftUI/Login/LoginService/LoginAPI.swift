//
//  LoginAPI.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 25/11/23.
//

import Foundation
import Combine


protocol LoginUserProtocol{
    func creareNewUserStatus(userName: String?, password: String?) -> Bool
}

enum LoginAPI: String{
    typealias ReturnType = LoginUserResponse
    case loginRequest = "auth/login"
}

extension LoginAPI{
    
    static var getLoginRequestUrl: URL {
        guard let url = URL(string: APIConstants.basedURL + "/" + LoginAPI.loginRequest.rawValue) else {
            fatalError("Invalid URL format")
        }
        return url
    }
}
























// MARK: - 

//struct LoginAPI:APIRequestConfiguration{
//    
//    typealias ReturnType = LoginUserResponse
//    
//    var method: HTTPMethod{
//        return .post
//    }
//    
//    var contentType: String {
//        return "application/json"
//    }
//    
//    var body: [String : Any]? {
//        return nil
//    }
//    
//    var queryParams: [String : Any]? {
//        return nil
//    }
//    
//    var headers: [String : String]? {
//        return nil
//    }
//    
//    public var path: String {
//        return "auth/login"
//    }
//    
//    
//    func asUrlRequest(_ user: LoginUser) -> URLRequest? {
//        guard var urlComponents = URLComponents(string: APIConstants.basedURL) else { return nil }
//        urlComponents.path = "\(urlComponents.path)/\(path)"
//        urlComponents.queryItems = addQueryItems(queryParams: queryParams)
//        guard let finalURL = urlComponents.url else {
//            // Log an error or return nil, indicating that URL creation failed.
//            return nil
//        }
//        var request = URLRequest(url: finalURL)
//        request.httpMethod = method.rawValue
//        guard let jsonBody = encodeToJson(object: user) else {
//            return nil
//        }
//        request.httpBody = jsonBody
//        // request.setValue("Your API Token key", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
//        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//        if let headers = headers {
//            request.allHTTPHeaderFields = headers
//        }
//        return request
//    }
//
//}
//
//
//extension LoginAPI{
//    
//    func httpMethod(for apiType: LoginAPIType) -> HTTPMethod {
//        switch apiType {
//        case .postLoginRequest:
//            return .post
//        case .getLoginResponse:
//            return .get
//        }
//    }
//}
