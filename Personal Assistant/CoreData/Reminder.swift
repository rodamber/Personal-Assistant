//
//  Reminder+CoreDataClass.swift
//  
//
//  Created by Rodrigo Bernardo on 15/01/21.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Reminder)
public class Reminder: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var creationDate: Date
    @NSManaged public var alertDate: Date?
    @NSManaged public var notes: String
    @NSManaged public var title: String
}
