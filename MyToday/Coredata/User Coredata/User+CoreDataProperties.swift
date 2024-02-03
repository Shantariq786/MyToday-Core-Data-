//
//  User+CoreDataProperties.swift
//  
//
//  Created by Ch. Shan on 10/30/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var image: Data?

}



//1. email search return object of user
// if user.password == password
// move to home page
