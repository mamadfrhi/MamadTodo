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
    private var todosContainer: TodosManagedObjectsContainer? {
        didSet {
            self.todos = todosContainer!.todos
        }
    } // TODO: Write a test to check count of these two arrays above
    private var services: ServicesType
    
    // MARK: Functions
    init(services: ServicesType) { self.services = services }
    
    func start() {
        fetch()
        viewDelegate?.refreshScreen()
    }
}

// MARK: - CoreData
// todos CRUD
extension MainVM {
    private func fetch() {
        services.fetch {
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
    
    func add(todo: Todo) {
        services.create(todo: todo) {
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
    
    private func delete(index: Int) {
        guard let todoNSManagedObj = todosContainer?.todosNSManagedObjects[index] else { return }
        services.delete(todoManagedObject: todoNSManagedObj) {
            [weak self]
            (result) in
            switch result {
            case .success:
                print("successfully deleted")
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
    
    func deleteButtonTapped(at: IndexPath) { delete(index: at.row) }
    
    func editButtonTapped(at: IndexPath) {
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
    
    func addButtonTapped(from controller: UIViewController) {
        coordinatorDelegate?.addButtonTapped(from: controller)
    }
}
