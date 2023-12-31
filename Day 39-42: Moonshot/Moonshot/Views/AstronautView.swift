//
//  AstronautView.swift
//  Moonshot
//
//  Created by Kasharin Mikhail on 02.08.2023.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static var previews: some View {
        AstronautView(astronaut: dev.astronauts["armstrong"]!)
            .preferredColorScheme(.dark)
    }
}
