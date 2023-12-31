//
//  PostRequestView.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 18.08.2023.
//

import SwiftUI

struct PostRequestView: View {
    @ObservedObject var store: StoreOf<OrderDomain>
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
//                Text("Your total is \(order.order.cost, format: .currency(code: "USD"))")
//                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        store.send(.post)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: Binding(
            get: { store.showAlert },
            set: { _ in store.send(.closeAlert) })
        ) {
            Button("OK") { }
        } message: {
            Text(store.alertMessage)
        }
    }
    
//    private func placeOrder() async {
//        guard let encoded = try? JSONEncoder().encode(order.order) else {
//            print("Failed to encode order")
//            return
//        }
//
//        let url = URL(string: "https://reqres.in/api/cupcakes")!
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//
//        do {
//            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
//            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
//            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(decodedOrder.type.lowercased()) cupcakes is on its way!"
//            showingConfirmation = true
//        } catch {
//            confirmationMessage = "Oops! Something went wrong"
//            showingConfirmation = true
//        }
//    }
}

struct PostRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PostRequestView(store: OrderDomain.previewStore)
    }
}
