//
//  LoginView.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 19/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username:String = ""
    @State private var password:String = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                LoginLabelText()
                UserImage()
                UsernameTextField(username: $username)
                PasswordSecureField(password: $password)
                
                Button(action: {
                    // loginButtonAction
                    print($username.wrappedValue)
                })
                {
                    LoginButtonContent()
                    // loginButtonDesign
                }
            }.padding()
            
            
        }
    }
}


#Preview {
    LoginView()
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
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 250, height: 55)
            .background(Color.green)
            .cornerRadius(35.0)
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

