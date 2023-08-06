//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import Foundation

class HabitsViewModel: ObservableObject {
    
    @Published var habits = [Habit]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        //        habits = [
        //            Habit(name: "Drink Water", amount: 1, amountPerDay: 3, measurement: "l"),
        //            Habit(name: "Wake up at 6am", amount: 10, amountPerDay: 31, measurement: "day")
        //        ]
        guard let data = UserDefaults.standard.data(forKey: "Habits") else {
            habits = []
            return
        }
        let decoder = JSONDecoder()
        if let habits = try? decoder.decode([Habit].self, from: data) {
            self.habits = habits
        }
        
        
    }
    
    func add(name: String, measurement: String, quantity: String) {
        guard let doubleQuantity = Double(quantity) else { return }
        let habit = Habit(name: name, amount: 0, amountPerDay: doubleQuantity, measurement: measurement)
        habits.append(habit)
    }
    
    func update(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id } ) else { return }
        habits[index] = habit
    }
    
}
