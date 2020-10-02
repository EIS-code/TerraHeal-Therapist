//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Jaydeep Vyas on 27/07/20.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
}
