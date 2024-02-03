//
//  CoredataManager.swift
//  MyToday
//
//  Created by Ch. Shan on 10/30/23.
//

import Foundation
import CoreData

class UserCoreDataManager {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyToday")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    
    func createUser(name: String, email: String, password: String) {
        let user = User(context: context)
        user.id = UUID()
        user.name = name
        user.password = password
        user.email = email
        
        saveContext()
    }
    
    
    func fetchAllUser() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            return users
        } catch {
            print("Failed to fetch todos: \(error)")
            return []
        }
    }
    
    
    func getUserById(id: UUID) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let matchingUsers = try context.fetch(fetchRequest)
            return matchingUsers.first
        } catch {
            print("Error fetching user by ID: \(error)")
            return nil
        }
    }
    
    
    func isEmailFound(email: String) -> Bool {
        // Replace the line below with your actual Core Data managed object context.
        let context = persistentContainer.viewContext // Replace 'persistentContainer' with your actual Core Data stack object
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let matchingUsers = try context.fetch(fetchRequest)
            return !matchingUsers.isEmpty
        } catch {
            print("Error fetching data: \(error)")
            return false
        }
    }
    
    
    func isEmailFoundWithUUID(email: String) -> UUID? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let matchingUsers = try context.fetch(fetchRequest)
            if matchingUsers.isEmpty{ // no email match
                return nil
            }else{ // array is not empty
                return matchingUsers[0].id
            }
            
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }
    
    
    
    
    func getUser(forEmail email: String, password: String) -> User? { // value , valid email and passwod
        // NIL , invalid email or password
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let matchingUsers = try context.fetch(fetchRequest)
            if let user = matchingUsers.first, user.password == password {
                return user
            } else {
                return nil
            }
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }
    
    
    func deleteUser(id: UUID) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let users = try context.fetch(fetchRequest)
            for user in users {
                context.delete(user)
            }
            
            // Save the context after deletion
            saveContext()
        } catch {
            print("Failed to delete todo: \(error)")
        }
    }
    
    
    func editUser(id: UUID, newPassword: String) {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        do {
            let users = try context.fetch(fetchRequest)
            for user in users {
                // Update the properties of the found todo
                user.password = newPassword
            }
            // Save the context after editing
            saveContext()
        } catch {
            print("Failed to edit user: \(error)")
        }
    }
    
    
    func saveUserImage(id: UUID, image: Data) {
        let managedContext = persistentContainer.viewContext
        // Check if a user with the given ID already exists
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        do {
            let users = try managedContext.fetch(fetchRequest)
            for user in users {
                user.image = image
            }
            saveContext()
        } catch {
            print("Error saving user image: \(error)")
        }
    }
    
    func getImage(id: UUID) -> Data? {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let matchingUsers = try context.fetch(fetchRequest)
            if let user = matchingUsers.first {
                return user.image
            } else {
                return nil
            }
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }
    
    
    func editUserName(id: UUID, Name: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        do {
            let users = try context.fetch(fetchRequest)
            
            for user in users {
                // Update the properties of the found todo
                user.name = Name
            }
            // Save the context after editing
            saveContext()
        } catch {
            print("Failed to edit user: \(error)")
        }
    }
    
    
    func editUserEmail(id: UUID, Email: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        do {
            let users = try context.fetch(fetchRequest)
            
            for user in users {
                // Update the properties of the found todo
                user.email = Email
            }
            // Save the context after editing
            saveContext()
        } catch {
            print("Failed to edit user: \(error)")
        }
    }
    
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
