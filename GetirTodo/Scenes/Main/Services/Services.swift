//
//  Services.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import CoreData

protocol ServicesType {
    func createOnStorage(todo: Todo, completion: @escaping (Result<Bool, Error>)->())
    func fetchTodos(completion: @escaping (Result<[NSManagedObject], Error>)->())
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
    func fetchTodos(completion: @escaping (Result<[NSManagedObject], Error>) -> ()) {
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
    
    func createOnStorage(todo: Todo, completion: @escaping (Result<Bool, Error>) -> ()) {
        storage.create(object: todo) { (result) in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
