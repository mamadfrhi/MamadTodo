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
    private var todos: [Todo] = []
    var todosContainer: TodosManagedObjectsContainer? {
        didSet {
            self.todos = todosContainer!.todos
        }
    } // TODO: Write a test to check count of these two arrays above
    private var services: ServicesType
    
    // MARK: Functions
    init(services: ServicesType) { self.services = services }
    
    func start() {
        fetch()
    }
}

// MARK: - CoreData
// todos CRUD
extension MainVM {
    private func fetch() {
        services.fetchTodos {
            [weak self]
            (result) in
            switch result {
            case .success(let todosManagedObjects):
                let todosContainer = TodosManagedObjectsContainer(todosNSManagedObjects: todosManagedObjects)
                self?.todosContainer = todosContainer
            case .failure(let error):
                self?.viewDelegate?.showError(errorMessage: error.localizedDescription)
            }
        }
    }
    
    private func add(todo: Todo) {
        services.createOnStorage(todo: todo) {
            [weak self]
            (result) in
            switch result {
            case .success:
                // TODO: add a good message view for the users
                print("successfully saved")
                self?.start()
            case .failure(let error):
                self?.viewDelegate?.showError(errorMessage: error.localizedDescription)
            }
        }
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
        // GoTo Details Page
        let todo = todos[row]
        didSelect(todo: todo, from: controller)
    }
}

// MARK: - ViewModelCoordinator
extension MainVM: MainViewModelCoordinatorDelegate {
    func didSelect(todo: Todo, from controller: UIViewController) {
        coordinatorDelegate?.didSelect(todo: todo,
                                       from: controller)
    }
}
