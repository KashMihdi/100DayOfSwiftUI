//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Kasharin Mikhail on 31.07.2023.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
