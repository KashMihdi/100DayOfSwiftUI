//
//  ContentView.swift
//  WordScramble
//
//  Created by Kasharin Mikhail on 25.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var useWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    @State private var animation = false
    @State private var animationReset = false
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.alphabet)
                        .autocorrectionDisabled()
                        .overlay(
                            Image(systemName: !newWord.isEmpty ? "xmark.circle" : "")
                                .onTapGesture {
                                    newWord = ""
                                },
                            alignment: .trailing
                        )
                }
                
                Section {
                    ForEach(useWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: startGame) {
                        HStack {
                            Image(systemName: "goforward")
                                .rotationEffect(.degrees(animationReset ? 360 : 0))
                            Text("Reset")
                        }
                        .foregroundColor(.black)
                        .font(.headline)
                    }
                    .animation(.spring(), value: animationReset)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Score:\(score)")
                        .font(.headline)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 4)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.purple.opacity(0.6), lineWidth: 4)
                                .scaleEffect(animation ? 1.5 : 1)
                                .opacity(animation ? 0 : 1)
                        )
                        
                        .animation(animation ? .easeIn(duration: 0.5) : .none, value: animation)
                }
            }
            .onSubmit(addWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { newWord = "" }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private func addWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count >= 3 else { return }
        guard answer != rootWord else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            useWords.insert(answer, at: 0)
            score += answer.count
        }
        newWord = ""
        animation = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            animation = false
        }
    }
    
    private func startGame() {
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                withAnimation {
                    rootWord = allWords.randomElement() ?? "silkworm"
                }
                reset()
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle")
    }
    
    private func reset() {
        useWords = []
        newWord = ""
        score = 0
        animationReset.toggle()
    }
    
    private func isOriginal(word: String) -> Bool {
        !useWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
