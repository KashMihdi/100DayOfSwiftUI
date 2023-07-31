//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Kasharin Mikhail on 31.07.2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: CurrencyChoice
}

enum CurrencyChoice: String, Codable, CaseIterable {
    case usd = "USD"
    case eur = "EUR"
    case rub = "RUB"
}
