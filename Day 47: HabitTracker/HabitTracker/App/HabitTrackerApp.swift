//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    @StateObject private var vm = HabitsViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
