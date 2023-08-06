//
//  HabitTextField.swift
//  HabitTracker
//
//  Created by Kasharin Mikhail on 06.08.2023.
//

import SwiftUI

struct HabitTextField: View {
    @Binding var habitText: String
    let text: String
    
    var body: some View {
        HStack {
            TextField(text, text: $habitText)
                .foregroundColor(.black)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.black)
                        .opacity(habitText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            habitText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.clear)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25).stroke(.green, lineWidth: 3)
        )
        .padding()
    }
}

struct HabitTextField_Previews: PreviewProvider {
    static var previews: some View {
        HabitTextField(habitText: .constant("Hello"), text: "Add yor...")
    }
}
