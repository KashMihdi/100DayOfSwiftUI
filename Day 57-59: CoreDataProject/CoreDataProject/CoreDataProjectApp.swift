//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Kasharin Mikhail on 14.09.2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            CandyView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
