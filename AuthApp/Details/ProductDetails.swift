//
//  ProductDetails.swift
//  AuthUI
//
//  Created by Muhammad Mamun on 11/12/23.
//

import SwiftUI


struct ProductDetails: View{
    
    var product: Product

    var body: some View {
        VStack{
            Text("Product Name: \(product.title)")
                .font(.largeTitle)
                .accessibilityIdentifier("productDetailsIdentifier")
            Text("\(product.description)")
        }
    }
}

//#Preview {
//    ProductDetails()
//}
