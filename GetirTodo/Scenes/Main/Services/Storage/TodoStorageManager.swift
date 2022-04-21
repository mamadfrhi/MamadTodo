//
//  TodoManager.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import CoreData

/*
 This manager also works purely on the `mainContext`.
 The one difference is it's context can be set externally.
 Meaning if you wanted to pass in a context configured purely for in-memory you could.
 
 This enables you to write unit tests that don't collide with app data.
 We well as run them quickly in memory.
 
 */
struct TodoStorageManager {
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
    }
}

// MARK: CRUD Implementation

extension TodoStorageManager: Storage {
    
    func fetch<T:NSManagedObject>(completion: @escaping (Result<[T]?, Error>) -> ()) {
        let fetchRequest = NSFetchRequest<T>(entityName: "TodoEntity")
        
        do {
            let todos = try mainContext.fetch(fetchRequest)
            completion(.success(todos))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func create<T>(object: T,
                   completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let todo = object as Any as? Todo else {
            completion(.failure(StorageError.storageDataGeneral))
            return
        }
        
        let todoEntity = TodoEntity(context: mainContext)
        
        todoEntity.id = UUID().uuidString
        todoEntity.createdAt = Date()
        
        todoEntity.title = todo.title
        todoEntity.description_todo = todo.description
        
        do {
            try mainContext.save()
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func delete<T>(object: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let todoManagedObject = object as Any as? NSManagedObject else {
            completion(.failure(StorageError.storageDataGeneral))
            return
        }
        
        mainContext.delete(todoManagedObject)
        
        do {
            try mainContext.save()
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
}


