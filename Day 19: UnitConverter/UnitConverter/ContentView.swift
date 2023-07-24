//
//  ContentView.swift
//  UnitConverter
//
//  Created by Kasharin Mikhail on 17.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var value = ""
    @State private var currentMeasure: Convert = .m
    @State private var transitionMeasure: Convert = .cm
    @FocusState var hiddenKeyboard: Bool
    
    var convertValue: Double {
        var millimetre: Double {
            switch currentMeasure {
            case .km:
                return (Double(value) ?? 0) * 1_000_000
            case .m:
                return (Double(value) ?? 0) * 1_000
            case .cm:
                return (Double(value) ?? 0) * 10
            case .mm:
                return (Double(value) ?? 0)
            }
        }
        
        switch transitionMeasure {
        case .km:
            return millimetre / 1_000_000
        case .m:
            return millimetre / 1_000
        case .cm:
            return millimetre / 10
        case .mm:
            return millimetre
        }
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                // Text Field
                Section {
                    TextField("Enter your value...", text: $value)
                        .focused($hiddenKeyboard)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Введите величину")
                }
                // Picker measure
                Section {
                    Picker("Выберите единицу измерения", selection: $currentMeasure) {
                        ForEach(Convert.allCases, id:\.self) {
                            Text($0.rawValue)
                        }
                    }
                }header: {
                    Text("Выберите единицы измерения")
                }
                // Amount
                Section {
                    Text(convertValue.formatted())
                }header: {
                    Text("Итого")
                }
                // Picker measure
                Section {
                    Picker("Выберите единицу перевода", selection: $transitionMeasure) {
                        ForEach(Convert.allCases, id:\.self) {
                            Text($0.rawValue)
                        }
                    }
                } header: {
                    Text("Единицы перевода")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        hiddenKeyboard.toggle()
                    }
                }
            }
        }
    }
}

extension ContentView {
    enum Convert: String, CaseIterable {
        case km = "Километр"
        case m = "Метр"
        case cm = "Сантиметр"
        case mm = "Миллиметр"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
