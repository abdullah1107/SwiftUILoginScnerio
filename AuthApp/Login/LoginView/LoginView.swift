//
//  LoginView.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 19/11/23.
//    userName: "kminchelle",
//    password: "0lelplR"

import Foundation
import SwiftUI
import SimpleToast


enum LoginScnerioAlert: String{
    case successLoginAlert = "You are now Successfully Login"
    case failedLoginAlert = "Please check your credentials and try again"
}

struct LoginView: View {
    
    @Binding var isLoggedIn: Bool
    @StateObject private var loginViewModel: LoginViewModel = LoginViewModel()
    @State private var isLoading = false
    @State var showToast: Bool = false
    
    private let toastOptions = SimpleToastOptions(
        hideAfter: 5
    )
    
    
    
    var body: some View {
        ZStack {
            VStack {
                LoginLabelText()
                    .accessibility(identifier: "login")
                UserImage()
                    .accessibility(identifier: "loginIcon")
                UsernameTextField(username: $loginViewModel.userName)
                    .accessibility(identifier: "usernameField")
                PasswordSecureField(password: $loginViewModel.password)
                    .accessibility(identifier: "passwordField")
                
                Button(action: {
                    isLoading = true
                    loginViewModel.creareNewUserStatus(username: loginViewModel.userName, password: loginViewModel.password){ result in
                        switch result {
                        case .success(let success):
                            isLoggedIn = success
                        case .failure:
                            isLoggedIn = false
                            withAnimation {
                                showToast.toggle()
                            }
                        }
                        isLoading = false
                    }
                })
                {
                    if isLoading {
                        ProgressView("Loading...")
                    } else {
                        LoginButtonContent(loginViewModel: loginViewModel)
                            .accessibility(identifier: "loginButton")
                    }
                }
                
                
            }.padding()
            
                .simpleToast(isPresented: $showToast, options: toastOptions) {
                    
                    Label(LoginScnerioAlert.failedLoginAlert.rawValue, systemImage: "exclamationmark.triangle")
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .foregroundColor(Color.red)
                        .cornerRadius(10)
                        .padding(.top)
                        .accessibilityIdentifier("loginFailedToast")
                }
        }
    }
}


#Preview {
    LoginView(isLoggedIn: .constant(false))
}


struct LoginLabelText: View {
    var body: some View {
        Text("Login User")
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
            .opacity(buttonOpacity)
            .disabled(!loginViewModel.formIsValid)
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
