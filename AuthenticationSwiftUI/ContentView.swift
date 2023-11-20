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







struct HomeView: View {
    var body: some View {
        VStack{
            Text("Home View DashBoard")
        }
    }
}

