//
//  ContentView.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 19/11/23.
//


import SwiftUI



struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var isSplashShowing:Bool = false
    
    var body: some View {
        
        VStack {
            if !isSplashShowing{
                SplashView()
            }else{
                if isLoggedIn{
                    HomeView()
                }else{
                    LoginView()
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                isSplashShowing = true
            }
        }
    }
    
}


#Preview {
    ContentView()
}



struct SplashView:View {
    
    @State private var animate = false
    
    var body: some View {
        Text("Hello, SwiftUI!")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .offset(x: 0, y: animate ? 0 : -50)
            .opacity(animate ? 1 : 0)
            .onAppear() {
                self.animate.toggle()
            }
    }
}


struct LoginView: View {
    
    @State private var username:String = ""
    @State private var password:String = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                HelloText()
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

struct HelloText: View {
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

struct HomeView: View {
    var body: some View {
        VStack{
            Text("Home View DashBoard")
        }
    }
}

