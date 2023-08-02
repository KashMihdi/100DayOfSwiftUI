//
//  ListLayout.swift
//  Moonshot
//
//  Created by Kasharin Mikhail on 02.08.2023.
//

import SwiftUI

struct ListLayout: View {
    
    let astronauts: [String : Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image("\(mission.image)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 65, height: 65)
                            .padding()
                            .offset(x: 5)
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(.lightBackground)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
            }
            .listRowBackground(Color.darkBackground)
            .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            .padding(.horizontal)
        }
        .listStyle(.plain)
    }
}

struct ListLayout_Previews: PreviewProvider {
    static var previews: some View {
        ListLayout(astronauts: dev.astronauts, missions: dev.missions)
    }
}
