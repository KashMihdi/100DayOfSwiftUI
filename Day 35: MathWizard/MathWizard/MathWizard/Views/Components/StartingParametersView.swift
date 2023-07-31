//
//  StartingParametersView.swift
//  MathWizard
//
//  Created by Kasharin Mikhail on 29.07.2023.
//

import SwiftUI

struct StartingParametersView: View {
    
    @Binding var number: Int
    
    let text: String
    let parameters: [Int]
    
    var body: some View {
        VStack {
            Picker(text, selection: $number) {
                ForEach(parameters, id: \.self) {
                    Text($0.formatted())
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
            }
            .colorMultiply(.white)
            .frame(width: 200, height: 120)
            .pickerStyle(.wheel)
        }
    }
}

struct AppearText: View {
    
    @State private var visibleText = ""
    let text: String
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(Array(visibleText), id: \.self) { char in
                Text(String(char))
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
            }
        }
        .animation(.linear, value: visibleText)
        .overlay(
            Image( "hat" )
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .rotationEffect(.degrees(-45))
                .offset(x: -27, y: text == visibleText ? -20 : 0)
                .opacity(text == visibleText ? 1 : 0)
                .animation(.easeInOut(duration: 1.5), value: visibleText),
            alignment: .topLeading
        )
        .onAppear {
            updateVisibleText()
        }
    }
    
    private func updateVisibleText() {
        var currentIndex = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if currentIndex < text.count {
                visibleText += String(text[text.index(text.startIndex, offsetBy: currentIndex)])
                currentIndex += 1
            } else {
                timer.invalidate()
            }
        }
        timer.fire()
    }
}

struct StartingParametersView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
            StartingParametersView(number: .constant(3), text: "Choose your digit", parameters: Array(2..<10))
        }
    }
}
