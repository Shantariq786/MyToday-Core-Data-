//
//  Todo+CoreDataProperties.swift
//  
//
//  Created by Ch. Shan on 11/4/23.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var title: String?
    @NSManaged public var discription: String?
    @NSManaged public var priority: String?
    @NSManaged public var id: UUID?
    @NSManaged public var userUUID: UUID?
    @NSManaged public var time: String?

}
