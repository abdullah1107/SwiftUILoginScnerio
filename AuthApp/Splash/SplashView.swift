//
//  SplashView.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 19/11/23.
//

import SwiftUI

struct SplashView:View {
    
    @State private var animate = false
    
    var body: some View {
        VStack{
            Spacer()
            Text("WelCome")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.green)
                .offset(x: 0, y: animate ? 0 : -50)
                .opacity(animate ? 1 : 0)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.animate.toggle()
                        
                    }
                }
            Spacer()
            Text("@CopyWrite: Muhammad Mamun")
                .font(.title3)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SplashView()
}
