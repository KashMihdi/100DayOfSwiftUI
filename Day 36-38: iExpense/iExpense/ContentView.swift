//
//  ContentView.swift
//  iExpense
//
//  Created by Kasharin Mikhail on 31.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    let item = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    expenses.items.append(item)
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
