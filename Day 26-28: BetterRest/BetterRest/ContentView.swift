//
//  ContentView.swift
//  BetterRest
//
//  Created by Kasharin Mikhail on 24.07.2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    private var bedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: calculateBedTime())
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                } header: {
                    Text("When do you want to wake up?")
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                }
                
                Section {
                    Picker("How many cups of coffee did you drink?", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text(($0).formatted())
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                }
                
                Section {
                    Text(bedTime)
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                } header: {
                    Text("Your ideal bedtime")
                        .font(.headline)
                }
            }
            .environment(\.locale, .init(identifier: "ru"))
            .navigationTitle("Better Rest")
        }
    }
    
    private func calculateBedTime() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            let sleepTime = wakeUp - prediction.actualSleep

            return sleepTime
            
        } catch {
            return Date()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
