//
//  HomeScreen.swift
//  AuthenticationSwiftUI
//
//  Created by Muhammad Mamun on 9/12/23.
//

import SwiftUI

struct HomeScreen: View {
    @AppStorage("showLoginSuccess") var showToast = false
    @ObservedObject var homeViewModel:DashBoadProductViewModel
    @State private var searchText:String = ""
    
    init(){
        homeViewModel = DashBoadProductViewModel()
        homeViewModel.getAllProducts()
    }
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return homeViewModel.products
        } else {
            return homeViewModel.products.filter { product in
                product.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    
    var body: some View {
        
//        if !showToast{
//            LoginSuccessToastView(message: LoginScnerioAlert.successLoginAlert.rawValue, success: $showToast)
//                .transition(.move(edge: .top))
//                .accessibilityIdentifier("loginSuccessAlert")
//        }
        
        NavigationView{
            VStack{
                List(filteredProducts) { product in
                    NavigationLink(destination: ProductDetails(product: product)) {
                        ProductItemRow(product: product)
                            .onAppear {
                                if product.id == homeViewModel.products.last?.id {
                                    homeViewModel.getAllProducts()
                                }
                            }
                            .accessibility(identifier: "productCellItem_\(product.id)")
                    }
                }
                
                .onChange(of: searchText) { _ in
                    debugPrint("searchText", searchText)
                }
                
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Product")
                .accessibilityIdentifier("searchProductIdentifier")
                .navigationTitle("DashBoard")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }

}

#Preview {
    HomeScreen()
}



// MARK: - Product Item Row
struct ProductItemRow: View {
    
    let product: Product
    @StateObject private var imageLoader = ImageLoader()
    @State private var image: UIImage?
    
    var body: some View {
        HStack {
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } else {
                Text("Loading...")
            }
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .padding(.leading, 5)
                Text(product.description)
                    .font(.subheadline)
                    .padding(.leading, 5)
            }
        }
        .onAppear {
            if let imageURL = URL(string:product.thumbnail){
                imageLoader.loadImage(from: imageURL)
            }else{
                print("Url issue")
            }
        }
        .onReceive(imageLoader.$downloadedImage, perform: { downloadedImage in
            image = downloadedImage
        })
    }
}



//struct ProductDetail: View{
//    
//    var product: Product
//
//    var body: some View {
//        Text("Product Detail: \(product.description)")
//    }
//
//}



// MARK: - ToastScreen
struct LoginSuccessToastView: View {
    let message: String
    @Binding var success:Bool
    
    var body: some View {
        VStack{
            Label {
                Text(message)
            } icon: {
                Image(systemName: "checkmark")
            }
            .padding()
            .background(Color.green.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .padding(.top)
            .onAppear{
                success = false
            }
        }
    }
}
