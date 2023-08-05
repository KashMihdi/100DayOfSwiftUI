//
//  Habit.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let amount: Double
    let amountPerDay: Double
    var progress: Double {
        amount / amountPerDay
    }
    var isComplete: Bool {
        amount == amountPerDay
    }
    
    init(name: String, amount: Double, amountPerDay: Double) {
        self.name = name
        self.amount = amount
        self.amountPerDay = amountPerDay
    }
}
