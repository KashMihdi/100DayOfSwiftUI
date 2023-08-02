//
//  GameView.swift
//  MathWizard
//
//  Created by Kasharin Mikhail on 30.07.2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm: QuestionViewModel
    
    let answerColumn: [GridItem] = [
        GridItem(.flexible(), spacing: 16, alignment: nil),
        GridItem(.flexible(), spacing: 16, alignment: nil)
    ]
    
    let correctColumn: [GridItem] = [
        GridItem(.flexible(), spacing: 16, alignment: nil),
        GridItem(.flexible(), spacing: 16, alignment: nil),
        GridItem(.flexible(), spacing: 16, alignment: nil),
    ]
    
    var body: some View {
        if vm.question.showResult {
            ZStack {
                LinearGradient(colors: [Color("back1"), Color("back2")], startPoint: .topTrailing, endPoint: .bottomLeading).ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("GAME OVER")
                        .font(.system(size: 60).bold())
                        .foregroundColor(Color("text"))
                    
                    Text("Your answers:")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color("text"))
                    
                    LazyVGrid(columns: correctColumn) {
                        ForEach(0..<vm.question.allQuestionText.count) { index in
                            Text(vm.question.allQuestionText[index])
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(
                                    vm.question.listOfCorrectAnswer[index] ? Color.green.cornerRadius(16) : Color.red.cornerRadius(16)
                                )
                        }
                    }
                    Text("score: \(vm.question.score)".uppercased())
                        .font(.largeTitle.bold())
                        .foregroundColor(Color("text"))
                    
                    Button {
                        vm.question.parameters = 1
                        dismiss()
                    } label: {
                        Text("Reset")
                            .font(.largeTitle)
                            .foregroundColor(Color("text"))
                            .padding()
                            .padding(.horizontal, 30)
                            .background(
                                Color("button").cornerRadius(24)
                            )
                    }

                }
            }
        } else {
            ZStack {
                Color("button").ignoresSafeArea()
                VStack(spacing: 30) {
                    ZStack {
                        Rectangle()
                            .fill(Color("back1"))
                            .cornerRadius(16)
                        Ellipse()
                            .fill(Color("back2").opacity(0.1))
                            .frame(width: 300, height: 100)
                            .rotationEffect(.degrees(45))
                            .offset(x:-200)
                        Circle()
                            .fill(Color("back2").opacity(0.1))
                            .frame(width: 400)
                            .offset(x: 200, y: -150)
                        Ellipse()
                            .fill(Color("back2").opacity(0.1))
                            .frame(width: 300, height: 100)
                            .rotationEffect(.degrees(-45))
                            .offset(x:-100, y: -100)
                        Circle()
                            .fill(Color("back2").opacity(0.1))
                            .frame(width: 400)
                            .offset(x: 100, y: 150)
                        
                        if !vm.question.allQuestionText.isEmpty {
                            VStack(spacing: 30) {
                                if vm.question.currentQuestion == 0 {
                                    Text("")
                                        .font(.system(size: 30))
                                        .foregroundColor(.gray.opacity(0.5))
                                        .foregroundColor(.black)
                                    Text(vm.question.allDisplayText[vm.question.currentQuestion])
                                        .font(.system(size: 60).bold())
                                        .foregroundColor(Color("text"))
                                        .foregroundColor(.black)
                                    Text(vm.question.allDisplayText[1])
                                        .font(.system(size: 30))
                                        .foregroundColor(.gray.opacity(0.5))
                                        .foregroundColor(.black)
                                } else if vm.question.currentQuestion == vm.question.numberOfQuestion - 1 {
                                    Text(vm.question.allDisplayText[vm.question.currentQuestion - 1])
                                        .font(.system(size: 30))
                                        .foregroundColor(.gray.opacity(0.5))
                                        .foregroundColor(.black)
                                    Text(vm.question.allDisplayText[vm.question.currentQuestion])
                                        .font(.system(size: 60).bold())
                                        .foregroundColor(Color("text"))
                                        .foregroundColor(.black)
                                    Text("")
                                        .font(.system(size: 30))
                                        .foregroundColor(.gray.opacity(0.5))
                                        .foregroundColor(.black)
                                } else {
                                    Text(vm.question.allDisplayText[vm.question.currentQuestion - 1])
                                        .font(.system(size: 30))
                                        .foregroundColor(.gray.opacity(0.5))
                                        .foregroundColor(.black)
                                    Text(vm.question.allDisplayText[vm.question.currentQuestion])
                                        .font(.system(size: 60).bold())
                                        .foregroundColor(Color("text"))
                                        .foregroundColor(.black)
                                    Text(vm.question.allDisplayText[vm.question.currentQuestion + 1])
                                        .font(.system(size: 30))
                                        .foregroundColor(.gray.opacity(0.5))
                                        .foregroundColor(.black)
                                }
                            }

                        }
                        
                    }
                    .frame(height: 450)
                    .clipped()
                    .overlay(
                        Text(vm.questionViewText())
                            .font(.title2)
                            .foregroundColor(Color("button"))
                            .padding(),
                        alignment: .bottomLeading
                    )
                    
                    LazyVGrid(columns: answerColumn, spacing: 16) {
                        ForEach(vm.choicesList(), id: \.self) { digit in
                            Button {
                                vm.checkAnswer(digit)
                                if vm.question.showResult {
                                    dismiss()
                                }
                            } label: {
                                Text(digit.formatted())
                                    .font(.largeTitle.bold())
                                    .foregroundColor(Color("text"))
                                    .frame(width: 180, height: 150)
                                    .background(
                                        LinearGradient(colors: [Color("back1").opacity(0.7), Color("back2")], startPoint: .topTrailing, endPoint: .bottomLeading).cornerRadius(30)
                                    )
                            }
                            .disabled(vm.question.animated ? true : false)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                vm.getMultiplyCollections()
                vm.getChooseNumber()
                vm.getListAllQuestions()
            }
        }

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(QuestionViewModel())
    }
}
