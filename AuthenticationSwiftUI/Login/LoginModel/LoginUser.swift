//
//  LoginUser.swift
//  HandlingGCD
//
//  Created by Muhammad Mamun on 14/10/23.
//

import Foundation


struct LoginUser: Codable{
    let userName:String
    let password:String
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case password = "password"
    }
}

struct LoginUserResponse: Codable {
    let id:Int
    let username, email, firstName, lastName: String
    let gender: String
    let image: String
    let token: String
}
