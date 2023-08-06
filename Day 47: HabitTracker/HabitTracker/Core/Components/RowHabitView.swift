//
//  RowHabitView.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 05.08.2023.
//

import SwiftUI

struct RowHabitView: View {
    
    let habit: Habit
    @Binding var showDetail: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            ProgressRectangle(isComplete: habit.isComplete)
                .fill(.green)
                .frame(width: max(UIScreen.main.bounds.width * habit.progress - 32, 0), height: 75)
                .animation(.spring(), value: habit.progress)
            
            HStack(alignment: .center) {
                Text(habit.name)
                    .font(.title3.bold())
                    .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                
                Spacer()
                Spacer()
 
                Image(systemName: habit.isComplete
                      ? "checkmark.circle"
                      : "clock.arrow.circlepath")
                .resizable()
                .scaledToFit()
                .frame(width: 30, alignment: .leading)
                
                Spacer()
                
                VStack {
                    Text(habit.progress.asPercentString())
                        .font(.title3.bold())
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text("\(habit.amount.asNumberStringPercent()) of \(habit.amountPerDay.asNumberStringDigit())")
                        .font(.callout)
                        .foregroundColor(.black.opacity(0.5))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .frame(width: 70)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
        .sheet(isPresented: $showDetail) {
            Text(habit.name)
        }
    }
}

struct ProgressRectangle: Shape {
    let isComplete: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: isComplete ? rect.maxX : rect.maxX * 0.85, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        
        return path
    }
}

struct RowHabitView_Previews: PreviewProvider {
    static var previews: some View {
        RowHabitView(habit: Habit(name: "Drink water", amount: 2, amountPerDay: 3, measurement: "l"), showDetail: .constant(false))
    }
}
