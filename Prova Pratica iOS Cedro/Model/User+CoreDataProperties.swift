//
//  User+CoreDataProperties.swift
//  
//
//  Created by Giovane Silva de Menezes Cavalcante on 19/07/2018.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var sites: NSSet?

}

// MARK: Generated accessors for sites
extension User {

    @objc(addSitesObject:)
    @NSManaged public func addToSites(_ value: Site)

    @objc(removeSitesObject:)
    @NSManaged public func removeFromSites(_ value: Site)

    @objc(addSites:)
    @NSManaged public func addToSites(_ values: NSSet)

    @objc(removeSites:)
    @NSManaged public func removeFromSites(_ values: NSSet)

}
