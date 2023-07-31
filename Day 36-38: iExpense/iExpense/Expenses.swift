//
//  Expenses.swift
//  iExpense
//
//  Created by Kasharin Mikhail on 31.07.2023.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
