//
//  TodoViewData.swift
//  MamadTodo
//
//  Created by iMamad on 4/22/22.
//


import Foundation

protocol TodoViewDataType {
    var id: String { get }
    var title: String { get }
    var description: String { get }
    var createdAt: String { get }
}

struct TodoViewData: TodoViewDataType {
    var id: String { return todo.id! }
    
    var title: String { return todo.title }
    
    var description: String { return todo.description }
    
    var createdAt: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: todo.createdAt ?? Date())
        return stringDate
    }
    
    
    let todo: Todo
    init(todo: Todo) { self.todo = todo }
}
