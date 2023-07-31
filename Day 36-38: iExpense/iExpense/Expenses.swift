//
//  Expenses.swift
//  iExpense
//
//  Created by Kasharin Mikhail on 31.07.2023.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: "Items") else {
            items = []
            return
        }
        let decoder = JSONDecoder()
        if let expenses = try? decoder.decode([ExpenseItem].self, from: data) {
            items = expenses
        }
    }
}
