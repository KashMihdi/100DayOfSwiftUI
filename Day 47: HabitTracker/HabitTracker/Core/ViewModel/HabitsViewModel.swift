//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import Foundation

class HabitsViewModel: ObservableObject {
    
    @Published var habits: [Habit] = []
    
    init() {
        habits = [
            Habit(name: "Drink Water", amount: 1, amountPerDay: 3),
            Habit(name: "Wake up at 6am", amount: 10, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 20, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 1, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 29, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 8, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 31, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 22, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 3, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 11, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 25, amountPerDay: 31),
            Habit(name: "Wake up at 6am", amount: 16, amountPerDay: 31)
        ]
    }
    
}
