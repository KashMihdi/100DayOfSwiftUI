//
//  ContentView.swift
//  iExpense
//
//  Created by Kasharin Mikhail on 31.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                displaySection(filter: "Personal")
                displaySection(filter: "Business")
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    @ViewBuilder
    func displaySection(filter: String) -> some View {
        Section {
            ForEach(expenses.items.filter { $0.type == filter } ) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: item.currency.rawValue))
                        .foregroundColor(textColor(for: item.amount))
                }
            }
            .onDelete { indexSet in
                let item = expenses.items.filter { $0.type == filter }[indexSet.first!]
                removeItem(withID: item.id)
            }
        } header: {
            Text(filter)
        }
    }
    
    func removeItem(withID id: UUID) {
        if let index = expenses.items.firstIndex(where: { $0.id == id }) {
            expenses.items.remove(at: index)
        }
    }
    
    func textColor(for amount: Double) -> Color {
        switch amount {
        case ..<10:
            return .black
        case 10..<100:
            return .green
        case 100..<1000:
            return .blue
        default:
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
