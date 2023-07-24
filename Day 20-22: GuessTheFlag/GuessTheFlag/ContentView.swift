//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kasharin Mikhail on 18.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var question = 1
    @State private var gameOver = false
    
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.3), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .headlineStyle()
//                    .font(.largeTitle.bold())
//                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                        Text("Answer \(question) of 8")
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("You score is \(score)")
        }
        .alert("You done", isPresented: $gameOver) {
            Button("Reset", action: reset)
        } message: {
            Text("Your score: \(score)")
        }
    }
    
    private func flagTapped(_ number: Int) {
        scoreTitle = number == correctAnswer ? "Correct" : "Wrong. That’s the flag of \(countries[number])"
        if scoreTitle == "Correct" {
            score += 10
        }
        showingScore.toggle()
    }
    
    private func askQuestion() {
        withAnimation {
            if question < 8 {
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
                question += 1
            } else {
                gameOver.toggle()
            }
        }
    }
    
    private func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        question = 1
    }
}
 
struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(.black.opacity(0.5), lineWidth: 4)
            )
            .shadow(radius: 10)
    }
}

struct TitleModifaer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
    }
}

extension View {
    func headlineStyle() -> some View {
        modifier(TitleModifaer())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
