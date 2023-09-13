//
//  DataController.swift
//  Bookworm
//
//  Created by Kasharin Mikhail on 13.09.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
