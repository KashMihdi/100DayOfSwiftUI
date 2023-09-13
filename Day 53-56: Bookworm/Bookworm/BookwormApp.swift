//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Kasharin Mikhail on 19.08.2023.
//

import SwiftUI

@main
struct BookwormApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
