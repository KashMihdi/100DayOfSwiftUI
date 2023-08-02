//
//  MainView.swift
//  MathWizard
//
//  Created by Kasharin Mikhail on 28.07.2023.
//

import SwiftUI

struct ParametersGameView: View {
    @EnvironmentObject var vm: QuestionViewModel
    @State private var screen = 1
    @Binding var showNextScreen: Bool
    
    private let numberOfQuestions = [5, 10, 15, 20]
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
        VStack(spacing: 30) {
            switch vm.question.parameters {
            case 1:
                VStack {
                    AppearText(text: "Choose your digit!")
                        .offset(y: 40)
                    StartingParametersView(
                        number: $vm.question.digit,
                        text: "Choose your digit!",
                        parameters: Array(2..<10))
                }
                .transition(transition)
            case 2:
                VStack {
                    AppearText(text: "Choose your question")
                        .offset(y: 40)
                    StartingParametersView(
                        number: $vm.question.numberOfQuestion,
                        text: "Choose your question",
                        parameters: numberOfQuestions
                    )
                }
            default:
                Text("")
            }
            
            Button(action: showNext) {
                Text(vm.question.parameters == 2 ? "Start" : "Next")
                    .font(.largeTitle)
                    .foregroundColor(Color("text"))
                    .padding()
                    .padding(.horizontal, 30)
                    .background(
                        Color("button").cornerRadius(24)
                    )
                    .animation(.none, value: screen)
            }
        }
        .animation(.easeInOut(duration: 0.55), value: screen)

    }
    
    func showNext() {
        vm.question.parameters += 1
        if vm.question.parameters == 3 {
             showNextScreen = true
        }
    }
}

struct ParametersGameView_Previews: PreviewProvider {
    static var previews: some View {
        ParametersGameView(showNextScreen: .constant(false))
            .environmentObject(QuestionViewModel())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.green)
    }
}
