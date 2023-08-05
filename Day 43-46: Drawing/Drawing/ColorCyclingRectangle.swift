//
//  RectengleView.swift
//  Drawing
//
//  Created by Kasharin Mikhail on 04.08.2023.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    let steps = 100
    var x = 0.0
    var y = 0.0

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: UnitPoint(x: x, y: y),
                            endPoint: UnitPoint(x: 1 - x, y: 1 - y)
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleView: View {
    @State private var colorCycle = 0.0
    @State private var x = 0.0
    @State private var y = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: colorCycle, x: x, y: y)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
                .onChange(of: colorCycle) { newValue in
                    if newValue <= 0.5 {
                        x = newValue * 2
                    } else {
                        y = (newValue - 0.5) * 2
                    }
                }
        }
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleView()
    }
}
