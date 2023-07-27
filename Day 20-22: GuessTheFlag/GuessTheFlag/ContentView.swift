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
                .init(color: Color(red: 0.4, green: 0.3, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.66, green: 0.55, blue: 0.5), location: 0.3)
            ],
                           center: .top,
                           startRadius: 200,
                           endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .headlineStyle()
                
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
                                .opacity(showingScore ? (number == correctAnswer ? 1 : 0.5) : 1)
                                .scaleEffect(showingScore ? (number == correctAnswer ? 1.1 : 0.8) : 1)
                                .rotation3DEffect(
                                    .degrees(showingScore && number == correctAnswer ? 360 : 0),
                                    axis: (x: 0, y: 1, z: 0))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                HStack {
                    if !showingScore {
                        Text("Score: \(score) ")
                            .font(.system(size: 40).bold())
                            .foregroundColor(.white)
                    } else {
                        Text(scoreTitle == "Correct" ? "+10" : "-10")
                            .font(.largeTitle.bold())
                            .foregroundColor(scoreTitle == "Correct" ? Color("lightGreen") : Color("darkRed"))
                            .scaleEffect(showingScore ? 2 : 0)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .animation(.easeInOut, value: showingScore)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showingScore.toggle()
            askQuestion()
        }
    }
    
    private func askQuestion() {
        if question < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            question += 1
        } else {
            gameOver.toggle()
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
            .foregroundColor(.white)
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
