//
//  Storage.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import CoreData

protocol Storage {
    func create<T>(object: T, completion: @escaping (Result<Bool, Error>) -> ())
    func delete<T>(object: T, completion: @escaping (Result<Bool, Error>) -> ())
    func fetch<T>(completion: @escaping (Result<[T]?, Error>) -> ())
}
struct StorageError {
    static let coreDataGeneral = NSError(domain: "An error raised while dealing with the storage.", code: 00, userInfo: nil)
    static let coreDataFetch = NSError(domain: "Something wrong happened while fetching from the storage.", code: 10, userInfo: nil)
    static let coreDataSave = NSError(domain: "Something wrong happened while saving on the storage.", code: 20, userInfo: nil)
    static let coreDataDelete = NSError(domain: "Something wrong happened while deleting on the storage.", code: 30, userInfo: nil)
}
