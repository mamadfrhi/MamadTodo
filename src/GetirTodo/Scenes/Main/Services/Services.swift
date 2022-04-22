//
//  Services.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import CoreData

protocol ServicesType {
    func fetch(completion: @escaping (Result<[NSManagedObject], Error>)->())
    func create(todo: Todo, completion: @escaping (Result<Bool, Error>)->())
    func delete(todoManagedObject: NSManagedObject, completion: @escaping (Result<Bool, Error>)->())
}

class Services {
    
    // MARK: Properties
    private let storage: Storage
    // MARK: Function
    required init(storage: Storage) {
        self.storage = storage
    }
}

extension Services: ServicesType {
    
    func fetch(completion: @escaping (Result<[NSManagedObject], Error>) -> ()) {
        storage.fetch { (result) in
            switch result {
            case .success(let todos):
                // convert nsmanagedobject to todoviewData
                if let todos = todos {
                    completion(.success(todos))
                }else {
                    completion(.failure(StorageError.storageDataGeneral))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func create(todo: Todo, completion: @escaping (Result<Bool, Error>) -> ()) {
        storage.create(object: todo) { (result) in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(todoManagedObject: NSManagedObject, completion: @escaping (Result<Bool, Error>) -> ()) {
        storage.delete(object: todoManagedObject) { (result) in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
