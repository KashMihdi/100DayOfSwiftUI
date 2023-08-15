//
//  NewHabitView.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 06.08.2023.
//

import SwiftUI

struct NewHabitView: View {
    @EnvironmentObject var vm: HabitsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var habitText = ""
    @State private var measure = ""
    @State private var quantity = ""
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer()
                
                Text("Add your new habit!")
                    .font(.largeTitle.bold())
                
                HabitTextField(habitText: $habitText, text: "Add your new habit...")
                
                HStack {
                    Text("What do we measure?")
                        .font(.headline)
                        .padding(.leading)
                    Spacer()
                    HabitTextField(habitText: $measure, text: "Measure")
                        .frame(width: 150)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                HStack {
                    HabitTextField(habitText: $quantity, text: "Quantity")
                        .frame(width: 150)
                        .keyboardType(.decimalPad)
                    Spacer()
                    Text("How many will you limit??")
                        .font(.headline)
                        .padding(.trailing)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button {
                    vm.add(name: habitText, measurement: measure, quantity: quantity)
                    dismiss()
                } label: {
                    Text("Confirm")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal, 80)
                        .background(Color.green.cornerRadius(37))
                }
                Spacer()
            }
        }
        .overlay(
            Image(systemName: "xmark")
                .font(.title.bold())
                .padding()
                .onTapGesture {
                    dismiss()
                },
            alignment: .topTrailing
        )
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView()
    }
}
