//
//  LoginView.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 19/11/23.
//
import Foundation
import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel: LoginViewModel = LoginViewModel()
    @State private var userName = ""
    @State private var password = ""
//    let getResult:Bool = loginViewModel
//        .creareNewUserStatus(userName: "kminchelle",
//                             password: "0lelplR")
    @Binding var isLoggedIn: Bool
    var body: some View {
        ZStack {
            VStack {
                LoginLabelText()
                UserImage()
                UsernameTextField(username: $userName)
                PasswordSecureField(password: $password)
                
//                Button(action: {
//                    //print("dsagfa", $userName.wrappedValue)
//                    let result:Bool = loginViewModel.creareNewUserStatus(userName: $userName.wrappedValue, password: $password.wrappedValue)
//                    isLoggedIn = result
//                    print(result,isLoggedIn)
//                })
//                {
//                    LoginButtonContent(loginViewModel: loginViewModel)
//                }
                
                Button("Login") {
                    loginViewModel.creareNewUserStatus(username: $userName.wrappedValue, password: $password.wrappedValue){ result in
                        
                        switch result {
                        case .success(let success):
                            isLoggedIn = true
                            print(success)
                            
                        case .failure(let failure):
                            isLoggedIn = false
                            print(failure.localizedDescription)
                        }
                        
                    }
                }
                
                .onAppear{
                    if loginViewModel.formIsValid{
                        debugPrint("Valid Form")
                    }else{
                        debugPrint("Form is not valid")
                    }
                }
            }.padding()
            
            
        }
    }
}


#Preview {
    LoginView(isLoggedIn: .constant(false))
}


struct LoginLabelText: View {
    var body: some View {
        Text("Hello")
            .font(.largeTitle)
            .foregroundColor(.green)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage: View {
    var body: some View {
        Image("user")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 30)
    }
}

struct LoginButtonContent: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 250, height: 55)
            .cornerRadius(35.0)
            .background(Color.green)
            //.opacity(buttonOpacity)
            //.disabled(!loginViewModel.formIsValid)
    }
    
    var buttonOpacity: Double {
        return loginViewModel.formIsValid ? 1 : 0.5
     }
}

struct UsernameTextField: View {
  
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0))
            .cornerRadius(5.0)
            .padding(.bottom, 10)
    }
}

struct PasswordSecureField: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0))
            .cornerRadius(5.0)
            .padding(.bottom, 30)
    }
}

