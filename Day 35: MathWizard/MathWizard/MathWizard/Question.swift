//
//  Question.swift
//  MathWizard
//
//  Created by Kasharin Mikhail on 29.07.2023.
//

import Foundation

struct Question {
    var parameters = 1
    var score = 0
    var digit = 2
    var numberOfQuestion = 5
    var chosenNumber: [Int] = []
    var answers: [Int] = []
    var correctAnswer  = 0
    var multiplyDigits: [Int] = Array(1...9)
    var currentQuestion = 0
    var animated = false
    var result: Bool? = nil
    var allQuestionText: [String] = []
    var allDisplayText: [String] = []
    var showResult = false
    var listOfCorrectAnswer: [Bool] = []
}
