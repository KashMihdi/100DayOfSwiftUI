//
//  Habit.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    var amount: Double
    let amountPerDay: Double
    var measurement: String
    var stride: Double {
        switch amountPerDay {
        case ..<10:
            return 0.25
        case 10...100:
            return 1
        default:
            return 100
        }
    }
    var progress: Double {
        amount / amountPerDay
    }
    var isComplete: Bool {
        amount == amountPerDay
    }
}
