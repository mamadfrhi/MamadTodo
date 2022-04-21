//
//  Todo.swift
//  GetirTodo
//
//  Created by iMamad on 4/20/22.
//

import Foundation

struct Todo {
    let id: String?
    let title: String
    let description: String
    let createdAt: Date?
}

protocol TodoViewDataType {
    var id: String { get }
    var title: String { get }
    var description: String { get }
    var createdAt: String { get }
}

struct TodoViewData: TodoViewDataType {
    var id: String { return todo.id! } // take care of force unwrap
    
    var title: String { return todo.title.capitalized }
    
    var description: String { return todo.description }
    
    var createdAt: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: todo.createdAt ?? Date())
        return stringDate
    }
    
    
    let todo: Todo
    init(todo: Todo) {
        self.todo = todo
    }
}
