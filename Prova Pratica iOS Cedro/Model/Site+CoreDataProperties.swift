//
//  Site+CoreDataProperties.swift
//  
//
//  Created by Giovane Silva de Menezes Cavalcante on 19/07/2018.
//
//

import Foundation
import CoreData


extension Site {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Site> {
        return NSFetchRequest<Site>(entityName: "Site")
    }

    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var logo: NSData?
    @NSManaged public var user: User?

}
