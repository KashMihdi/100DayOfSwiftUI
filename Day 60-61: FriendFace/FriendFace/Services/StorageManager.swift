//
//  StorageManager.swift
//  FriendFace
//
//  Created by Kasharin Mikhail on 19.09.2023.
//

import Foundation
import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserData")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - CRUD
    
    func create(_ users: [User]) {
        for user in users {
            let cachedUser = CachedUser(context: viewContext)
            cachedUser.id = user.id
            cachedUser.about = user.about
            cachedUser.address = user.address
            cachedUser.age = Int16(user.age)
            cachedUser.email = user.email
            cachedUser.company = user.company
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.registered = user.registered
            if let tagsData = try? JSONEncoder().encode(user.tags) {
                cachedUser.tags = tagsData
            }
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: viewContext)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                cachedUser.addToFriend(cachedFriend)
            }
        }
        saveContext()
    }
    
    
    
    func fetchData(completion: (Result<[CachedUser], Error>) -> Void) {
        let fetchRequest = CachedUser.fetchRequest()
        
        do {
            let objects = try viewContext.fetch(fetchRequest)
            completion(.success(objects))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func delete(_ users: [CachedUser]) {
        for user in users {
            viewContext.delete(user)
            saveContext()
        }
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

