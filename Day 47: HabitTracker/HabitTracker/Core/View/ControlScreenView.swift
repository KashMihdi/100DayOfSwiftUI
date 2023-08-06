//
//  ControlScreenView.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import SwiftUI

struct ControlScreenView: View {
    @EnvironmentObject var vm: HabitsViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var selectedItem: Habit
    @State private var amount = 0.0
    
    var body: some View {
        
        VStack(spacing: 20) {
            HStack(spacing: 30) {
                Text(selectedItem.name)
                    .font(.title2.bold())
                
                ZStack {
                    Circle()
                        .strokeBorder(.blue.opacity(0.3), lineWidth: 10)
                        .frame(width: 100)
                    
                    DetailCircle(startAngle: 0, endAngle: 360 * selectedItem.progress, clockwise: false)
                        .strokeBorder(.green, lineWidth: 10)
                        .frame(width: 100)
                        .animation(.spring(), value: selectedItem.progress)
                    
                    Text(selectedItem.progress.asPercentString())
                        .font(.title3.bold())
                        .animation(.none)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 100)

            
            Stepper("Add one?", value: $amount, in: 0...selectedItem.amountPerDay, step: selectedItem.stride)
                .padding(.horizontal)
                .font(.title3.bold())
            
            Button {
                vm.update(selectedItem)
                dismiss()
            } label: {
                Text("Confirm")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.green.cornerRadius(16))
            }

            
            Spacer()
        }
        .padding(.top)
        .onAppear {
            amount = selectedItem.amount
        }
        .onChange(of: amount) { newValue in
            withAnimation(.linear) {
                selectedItem.amount = newValue
            }
        }
    }
}

struct DetailCircle: InsettableShape {
    var startAngle: Double
    var endAngle: Double
    let clockwise: Bool
    var insertAmount = 0.0
    var animatableData: AnimatablePair<Double, Double> {
        get {
           AnimatablePair(startAngle, endAngle)
        }
        set {
            startAngle = newValue.first
            endAngle = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let modifaerStart: Angle = .degrees(startAngle - 90)
        let endModifaer: Angle = .degrees(endAngle - 90)
        var path = Path()
        
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2 - insertAmount,
            startAngle: modifaerStart,
            endAngle: endModifaer,
            clockwise: clockwise
        )
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insertAmount = amount
        return arc
    }
}

struct ControlScreenView_Previews: PreviewProvider {
    @State static var habit = Habit(name: "Drink water", amount: 2, amountPerDay: 3, measurement: "l")
    
    static var previews: some View {
        ControlScreenView(selectedItem: $habit)
            .environmentObject(HabitsViewModel())
    }
}
