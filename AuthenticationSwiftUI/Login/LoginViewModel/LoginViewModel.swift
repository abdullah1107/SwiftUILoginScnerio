//
//  LoginViewModel.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 28/11/23.
//

import Foundation
import Combine
import SwiftUI


class LoginViewModel: ObservableObject, LoginUserProtocol{
    
    var cancellable: Set<AnyCancellable> = []
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @Published var userName:String = ""
    @Published var password:String = ""
    @Published var formIsValid = false
    
    init(){
        self.chekLoginFormVilidity()
    }
    
    func creareNewUserStatus(userName: String?, password: String?) -> Bool {
        let user = LoginUser(userName: "kminchelle", password: "0lelplR")
        LoginNetworkService.createUser(urlPath: LoginAPI.getLoginRequestUrl, user: user, responseType: LoginAPI.ReturnType.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] responseObject in
                self?.isLoggedIn = true
            })
            .store(in: &cancellable)
        
        return isLoggedIn
    }
    
    
    func chekLoginFormVilidity(){
        isSignInFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &cancellable)
    }
    
    
    var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
        $userName
            .map { name in
                return name.count >= 5
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { password in
                return password.count >= 6
            }
            .eraseToAnyPublisher()
    }
    
    var isSignInFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isUserNameValidPublisher,
            isPasswordValidPublisher)
        .map { isNameValid, isPasswordValid in
            return isNameValid && isPasswordValid
        }
        .eraseToAnyPublisher()
    }
    
    private func isValidLogin(username: String, password: String) -> Bool {
        return !username.isEmpty && !password.isEmpty
    }
    
}



// MARK: - Extension

//extension LoginViewModel{
//    
//    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
//        userLoginInfo.$userEmail
//        .map { email in
//            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
//            return emailPredicate.evaluate(with: email)
//        }
//        .eraseToAnyPublisher()
//    }
//    
//  
//    
//    var passwordMatchesPublisher: AnyPublisher<Bool, Never> {
//        Publishers.CombineLatest(userLoginInfo.$userPassword, userLoginInfo.$userRepeatedPassword)
//        .map { password, repeated in
//            return password == repeated
//        }
//        .eraseToAnyPublisher()
//    }
//}
