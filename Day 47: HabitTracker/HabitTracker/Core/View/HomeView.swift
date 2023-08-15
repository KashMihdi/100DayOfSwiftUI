//
//  HomeView.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HabitsViewModel
    @State private var showControlScreen = false
    @State private var showNewHabitView = false
    @State private var selectedHabit: Habit = Habit(name: "", amount: 0, amountPerDay: 0, measurement: "")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.habits) { habit in
                    Button {
                        selectedHabit = habit
                        showControlScreen.toggle()
                    } label: {
                        RowHabitView(habit: habit, showDetail: $showControlScreen)
                    }
                }
                .onDelete(perform: delete)
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 80)
            .listStyle(.inset)
            .navigationTitle("Track your habit!")
        }
        .onDisappear {
           UserDefaults.standard.set(Date(), forKey: "Date")
        }
        .sheet(isPresented: $showControlScreen) {
            ControlScreenView(selectedItem: $selectedHabit)
                .presentationDetents([.fraction(0.37)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showNewHabitView) {
            NewHabitView()
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Text(vm.currentDay.formatted(date: .abbreviated, time: .omitted))
                    .font(.title2.bold())
                    .padding(.leading, 20)
                    .underline()
                Spacer()
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .padding()
                    .background(.green)
                    .clipShape(Circle())
                    .onTapGesture {
                        showNewHabitView.toggle()
                    }
                
            }
            .padding([.bottom, .horizontal], 20)
            .offset(y: 20)
            .background(.white)
        }
    }
    
    private func delete(indexSet: IndexSet) {
        vm.habits.remove(atOffsets: indexSet)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HabitsViewModel())
    }
}
