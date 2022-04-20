//
//  MainVM.swift
//  GetirTodo
//
//  Created by iMamad on 4/20/22.
//

import UIKit

class MainVM {
    // MARK: Delegates
    var coordinatorDelegate: MainViewModelCoordinatorDelegate?
    var viewDelegate: MainViewModelViewDelegate?
    
    // MARK: Properties
    private var todos: [Todo] = [Todo(id: "10", title: "nice todo",
                                      description: "good", createdAt: Date()),
                                 Todo(id: "10", title: "nice todo",
                                      description: "good", createdAt: Date())]
    
    // MARK: Functions
    init() {}
    
    func start() {
        viewDelegate?.refreshScreen()
    }
}

// MARK: - ViewModelType
extension MainVM: MainViewModelType {
    
    func numberOfRows() -> Int { return todos.count }
    
    func cellDataFor(row: Int) -> TodoViewData {
        let viewData = TodoViewData(todo: todos[row])
        return viewData
    }
    
    func add() {
        print("Add new todo tapped")
    }
    
    func delete(at: IndexPath) {
        print("delete todo tapped")
    }
    
    func edit(at: IndexPath) {
        print("edit todo tapped")
    }
    
    func refreshView() {
        print("refresh view happened")
    }
    
    func didSelectRow(_ row: Int, from controller: UIViewController) {
        print("row \(row) selected")
    }
}

// MARK: - ViewModelCoordinator
extension MainVM: MainViewModelCoordinatorDelegate {
    func didSelect(todo: Todo, from controller: UIViewController) {
        print("I'm in coordinator ")
    }
}
