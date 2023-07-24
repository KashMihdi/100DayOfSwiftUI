//
//  ContentView.swift
//  RPS
//
//  Created by Kasharin Mikhail on 19.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    var winnerCombination = [
        "✂️" : "🧻",
        "🧻" : "🪨",
        "🪨" : "✂️"
    ]
    
    @State private var randomMove = Int.random(in: 0...2)
    @State private var conditionMove = Bool.random()
    @State private var score = 0
    @State private var question = 1
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.7).ignoresSafeArea()
                VStack(spacing: 40) {
                    Text("Your score: \(score)")
                        .font(.largeTitle)
                        .padding(.top, 50)
                    
                    VStack {
                        Text(Array(winnerCombination.keys)[randomMove])
                            .font(.system(size: 100))
                        
                        Text("You must:")
                            .font(.title)
                        Text("\(conditionMove ? "Win" : "Lose")")
                            .font(.largeTitle)
                    }

                    
                    HStack(spacing: 20) {
                        ForEach(Array(winnerCombination.keys), id: \.self) { move in
                            Button {
                                getResult(move)
                            } label: {
                                Text(move)
                                    .font(.system(size: 80))
                                    .padding()
                                    .background(
                                        Color.blue.cornerRadius(16)
                                    )
                                    .shadow(radius: 10)
                            }

                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    
                    Text("Attempt #\(question)")
                        .font(.largeTitle)
                    
                    Spacer()
                }
            }
            .navigationTitle("Rock-Scissors-Paper")
            .alert("GAME OVER", isPresented: $showingAlert) {
                Button("Reset") {
                    score = 0
                    question = 1
                }
            } message: {
                Text("Your score: \(score)")
            }
        }
    }
    
    private func getResult(_ move: String) {
        if winnerCombination[move] == Array(winnerCombination.keys)[randomMove], conditionMove {
            score += 10
        } else if winnerCombination[move] != Array(winnerCombination.keys)[randomMove], !conditionMove {
            score += 10
        } else {
            score -= 10
        }
        reset()
    }
    
    private func reset() {
        randomMove = Int.random(in: 0...2)
        conditionMove = Bool.random()
        question += 1
        if question == 10 {
            showingAlert.toggle()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
