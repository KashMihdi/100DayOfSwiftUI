//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Kasharin Mikhail on 19.09.2023.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: Data?
    @NSManaged public var friend: NSSet?
    
    public var wrappedAbout: String {
        about ?? "Haven't about"
    }
    public var wrappedAddress: String {
        address ?? "Haven't address"
    }
    public var wrappedCompany: String {
        company ?? "Haven't company"
    }
    public var wrappedEmail: String {
        email ?? " email"
    }
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    public var wrappedRegistered: Date {
        registered ?? Date()
    }
    
    public var candyArray: [CachedFriend] {
        let set = friend as? Set<CachedFriend> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }

}

// MARK: Generated accessors for friend
extension CachedUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CachedFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CachedFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
