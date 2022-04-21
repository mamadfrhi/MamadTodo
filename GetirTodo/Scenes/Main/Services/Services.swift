//
//  Services.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import Foundation

protocol ServicesType {
    func createOnStorage(todo: Todo, completion: @escaping (Result<Bool, Error>)->())
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
