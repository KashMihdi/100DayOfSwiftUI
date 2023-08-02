//
//  PreviewProvided-Extension.swift
//  Moonshot
//
//  Created by Kasharin Mikhail on 02.08.2023.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() {}
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    var crew: [CrewMember] {
        return missions[0].crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
   
}
