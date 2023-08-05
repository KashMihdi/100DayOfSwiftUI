//
//  HomeView.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HabitsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.habits) { habit in
                    RowHabitView(habit: habit)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 80)
            .listStyle(.inset)
            .navigationTitle("Track your habit!")
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.title2.bold())
                    .padding(.leading, 20)
                    .underline()
                Spacer()
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .padding()
                    .background(.green)
                    .clipShape(Circle())
                    
            }
            .padding([.bottom, .horizontal], 20)
            .offset(y: 20)
            .background(.white)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
