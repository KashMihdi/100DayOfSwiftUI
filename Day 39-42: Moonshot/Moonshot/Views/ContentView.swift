//
//  ContentView.swift
//  Moonshot
//
//  Created by Kasharin Mikhail on 01.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @AppStorage("showingGrid") var showingGrid = false
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label: {
                    Image(systemName: showingGrid ? "list.dash" : "square.grid.2x2")
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            // background for NavBar
            /*
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Moonshot")
                        .font(.title)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "circle")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.red, for: .navigationBar)
            */
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
