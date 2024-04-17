//
//  User+CoreDataProperties.swift
//  
//
//  Created by Kovalev Gleb on 09.04.2024.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var addressName: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var flat: Int16

}
