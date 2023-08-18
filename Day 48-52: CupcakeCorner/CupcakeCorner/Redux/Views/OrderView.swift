//
//  OrderView.swift
//  CupcakeCorner
//
//  Created by Kasharin Mikhail on 16.08.2023.
//

import SwiftUI

struct OrderView: View {
    @StateObject private var store: StoreOf<OrderDomain> = OrderDomain.previewStore
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker(
                        "Select your cake type",
                        selection: Binding(
                            get: { store.type },
                            set: { store.send(.setCakeType($0)) })
                    ) {
                        ForEach(store.types, id: \.self, content: Text.init)
                    }
                    Stepper(
                        "Number of cakes: \(store.quantity)",
                        value: Binding(
                            get: { store.quantity },
                            set: { store.send(.setCakeQuantity($0))}),
                        in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: Binding(
                        get: { store.specialRequestEnabled},
                        set: { store.send(.setSpecialRequest($0))}).animation())
                    
                    if store.specialRequestEnabled {
                        Group {
                            Toggle("Add extra frosting", isOn: Binding(
                                get: { store.extraFrosting },
                                set: { store.send(.setExtraFrosting($0))}))
                            
                            Toggle("Add extra sprinkles?", isOn: Binding(
                                get: { store.addSprinkles },
                                set: { store.send(.addSprinkles($0))}))
                        }
                    }
                }
                
                Section {
                    NavigationLink {
                        PersonalView(store: store)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
