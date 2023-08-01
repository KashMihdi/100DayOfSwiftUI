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
        if !expenses.items.filter({ $0.type == filter }).isEmpty{
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
                    remove(at: indexSet, filter: filter)
                }
            } header: {
                Text(filter)
            }
        }
    }
    
    func remove(at offsets: IndexSet, filter name: String) {
        guard let index = offsets.first else { return }
        let item = expenses.items.filter { $0.type == name }[index]
        if let index = expenses.items.firstIndex(where: { $0.id == item.id }) {
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
