//
//  QuestionViewModel.swift
//  MathWizard
//
//  Created by Kasharin Mikhail on 29.07.2023.
//

import SwiftUI

class QuestionViewModel: ObservableObject {
    
    @Published var question = Question()
    
    func getMultiplyCollections() {
        let repeats: Int = (question.numberOfQuestion / 9) + 1
        question.multiplyDigits = Array(repeating: 1...9, count: repeats).flatMap { $0.shuffled() }
    }
    
    func nextQuestion() {
        question.currentQuestion += 1
        if question.currentQuestion == question.numberOfQuestion {
            question.chosenNumber = []
            question.showResult = true
            return
        }
        question.chosenNumber = []
        getChooseNumber()
    }
    
    func getMultiplyDigit() -> Int {
        question.multiplyDigits[question.currentQuestion]
    }
    
    func getChooseNumber() {
        let multiplyDigit = getMultiplyDigit()
        let correctAnswer = multiplyDigit * question.digit
        question.correctAnswer = correctAnswer
        let randomNumbers = (abs(correctAnswer - 10)...(correctAnswer + 20)).filter { $0 % multiplyDigit == 0 && $0 != correctAnswer }.prefix(3)

        question.chosenNumber = ([correctAnswer] + Array(randomNumbers)).shuffled()
    }
    
    func resetGame() {
        question.score = 0
        question.chosenNumber = []
        question.answers = []
        question.correctAnswer  = 0
        question.multiplyDigits = Array(1...9)
        question.currentQuestion = 0
        question.animated = false
        question.result = nil
        question.allQuestionText = []
        question.showResult = false
        question.listOfCorrectAnswer = []
    }
    
    func checkAnswer(_ digit: Int) {
        if digit == question.correctAnswer {
            question.score += 10
            question.result = true
            
        } else {
            question.score -= 10
            question.result = false
        }
        question.listOfCorrectAnswer.append(digit == question.correctAnswer)
        question.animated = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.nextQuestion()
            self?.question.animated = false
            self?.question.result = nil
        }
    }
    
    func getListAllQuestions() {
        for number in 0..<question.numberOfQuestion {
            let answer = question.digit * question.multiplyDigits[number]
            let questions = "\(question.digit) x \(question.multiplyDigits[number]) = \(answer)"
            let displayQuestions = "\(question.digit) x \(question.multiplyDigits[number]) = ?"
            question.allQuestionText.append(questions)
            question.allDisplayText.append(displayQuestions)
        }
    }
    
    func answerViewText() -> String {
        if question.animated {
            return  "\(question.digit) x \(getMultiplyDigit()) = \(question.correctAnswer)"
        } else {
            return "\(question.digit) x \(getMultiplyDigit()) = ?"
        }
    }
    
    func questionViewText() -> String {
        "Question \(question.currentQuestion + 1) / \(question.numberOfQuestion)"
    }
    
    func choicesList() -> [Int] {
        question.chosenNumber
    }
    
}
