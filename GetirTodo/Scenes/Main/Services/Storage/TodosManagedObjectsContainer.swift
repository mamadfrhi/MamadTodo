//
//  TodosManagedObjectsContainer.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import CoreData
import Foundation


// TODO: Instead of this container create a wrapper
// for the todo NSManagedObject

class TodosManagedObjectsContainer {
    
    // MARK: Properties
    let todosNSManagedObjects: [NSManagedObject]!
    var todos: [Todo] = []
    
    // MARK: Init
    required init(todosNSManagedObjects: [NSManagedObject]) {
        self.todosNSManagedObjects = todosNSManagedObjects
        convertNSManagedObjectsToTodos()
    }
    
    private func convertNSManagedObjectsToTodos() {
        
        for nsManagedObj in todosNSManagedObjects {
            // unwrap
            if let id = nsManagedObj.value(forKey: "id"),
               let title = nsManagedObj.value(forKey: "title"),
               let description = nsManagedObj.value(forKey: "description_todo"),
               let createdAtObj = nsManagedObj.value(forKey: "createdAt") {
                // to string
                let id = "\(id)"
                let title = "\(title)"
                let description = "\(description)"
                // to date
                let cratedAt = createdAtObj as! Date // take care of force unwrap
                
                let todo = Todo(id: id,
                                title: title,
                                description: description,
                                createdAt: cratedAt)
                
                todos.append(todo)
            }
        }
    }
}
