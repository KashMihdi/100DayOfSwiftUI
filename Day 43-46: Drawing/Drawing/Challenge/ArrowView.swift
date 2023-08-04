//
//  ContentView.swift
//  Drawing
//
//  Created by Kasharin Mikhail on 02.08.2023.
//

import SwiftUI

struct Arrow : Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX * 0.33, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX * 0.33, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.66, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.66, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 3))
        path.closeSubpath()
        return path
    }
}


struct ArrowView: View {
    @State private var lineWidth = 1.0
    
    var body: some View {
        VStack(spacing: 60) {
            ZStack {
                Text("Look here!")
                    .foregroundColor(.red)
                    .padding(20)
                    .background(Color.red.cornerRadius(16))
                Text("Look here!")
                    .blur(radius: 2)
            }
            .font(.largeTitle)
            .compositingGroup()
                
            Arrow()
                .stroke(.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 250)
                .shadow(color: .red, radius: 10, x: 10, y: 10)
            
            Slider(value: $lineWidth, in: 1...10, step: 1)
                .tint(.red)
                .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            lineWidth = 10
        }
        .animation(.spring().repeatForever(), value: lineWidth)
        .background(.black)
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
