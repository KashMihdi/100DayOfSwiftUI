//
//  MainView.swift
//  MathWizard
//
//  Created by Kasharin Mikhail on 29.07.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = QuestionViewModel()
    @State private var showQuestions = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("back1"), Color("back2")], startPoint: .topTrailing, endPoint: .bottomLeading).ignoresSafeArea()
            
            VStack {
                Image("wizard")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                ParametersGameView(showNextScreen: $showQuestions)
                    .offset(y: -30)
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
            }
        }
        .fullScreenCover(isPresented: $showQuestions, onDismiss: vm.resetGame) {
            GameView()
        }
        .environmentObject(vm)
        .animation(.spring(), value: showQuestions)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
