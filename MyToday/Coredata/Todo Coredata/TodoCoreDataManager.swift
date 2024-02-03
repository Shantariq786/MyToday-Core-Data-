//
//  TodoCoreDataManager.swift
//  MyToday
//
//  Created by Ch. Shan on 11/4/23.
//

import Foundation
import UIKit
import CoreData

class TodoCoreDataManager {
    
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
    
    
    
    func createTodo(uuid:UUID, title: String, description: String, priority: String, time: String, userID: UUID) {
        let todo = Todo(context: context)
        todo.id = uuid
        todo.title = title
        todo.discription = description
        todo.priority = priority
        todo.time = time
        todo.userUUID = userID
        
        saveContext()
    }
    
    
    func fetchTodo(userId:String) -> [Todo] {
        
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userUUID == %@", userId)
        
        do {
            let todos = try context.fetch(fetchRequest)
            return todos
            
        } catch {
            print("Failed to delete todo: \(error)")
            return []
        }
        
        
    }
    
    
    
    func deleteTodo(id: UUID) {
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)

        do {
            let todos = try context.fetch(fetchRequest)
            for todo in todos {
                context.delete(todo)
            }

            // Save the context after deletion
            saveContext()
        } catch {
            print("Failed to delete todo: \(error)")
        }
    }
    
    
    
    
    func editTodo(id: UUID, newTitle: String, newDescription: String, newPriority: String, newTime: String) {
        
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)

        do {
            let todos = try context.fetch(fetchRequest)
            
            for todo in todos {
                // Update the properties of the found todo
                todo.title = newTitle
                todo.discription = newDescription
                todo.priority = newPriority
                todo.time = newTime
            }

            // Save the context after editing
            saveContext()
        } catch {
            print("Failed to edit todo: \(error)")
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



