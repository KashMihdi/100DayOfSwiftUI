//
//  PersonalView.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 18.08.2023.
//

import SwiftUI

struct PersonalView: View {
    
    @ObservedObject var store: StoreOf<OrderDomain>
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: Binding(
                    get: { store.name },
                    set: { store.send(.addName($0)) }))
                TextField("Street Address", text: Binding(
                    get: { store.streetAddress },
                    set: { store.send(.addAddress($0)) }))
                TextField("City", text: Binding(
                    get: { store.city },
                    set: { store.send(.addCity($0)) }))
                TextField("Zip", text: Binding(
                    get: { store.zip },
                    set: { store.send(.addZip($0)) }))
            }
            
            Section {
                NavigationLink {
                    PostRequestView(store: store)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!store.isValidAddress)
        }
        .onAppear {
            store.send(.checkValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PersonalView(store: OrderDomain.previewStore)
        }
    }
}
