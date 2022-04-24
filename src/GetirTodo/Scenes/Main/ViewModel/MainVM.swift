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
    var todoObjects: [TodoObjectType]? {
        didSet {
            viewDelegate?.refreshScreen()
        }
    }
    var services: Serviceable
    
    // MARK: Functions
    init(services: Serviceable) { self.services = services }
    
    func start() {
        fetch()
        viewDelegate?.refreshScreen()
    }
}

// MARK: - CoreData
extension MainVM {
    private func fetch() {
        services.fetch {
            [weak self]
            (result) in
            switch result {
            case .success(let todosManagedObjects):
                self?.todoObjects = todosManagedObjects.compactMap{
                    TodoObject(nsManagedObject: $0)
                }
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
    
    func delete(index: Int) {
        guard let todoNSManagedObj = todoObjects?[index].todoNSManagedObject else { return }
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
    
    func update(todoObject: TodoObject) {
        services.update(todoManagedObject: todoObject) {
            [weak self]
            (result) in
            switch result {
            case .success:
                self?.start()
            case .failure(let error):
                self?.viewDelegate?.showError(errorMessage: error.localizedDescription)
            }
        }
    }
}

// MARK: - ViewModelType
extension MainVM: MainViewModelType {
    
    func numberOfRows() -> Int { return todoObjects!.count }
    
    func cellDataFor(row: Int) -> TodoViewData {
        let viewData = todoObjects![row].todoViewData!
        return viewData
    }
    
    func deleteButtonTapped(at: IndexPath) { delete(index: at.row) }
    
    func editButtonTapped(at: IndexPath, from controller: UIViewController) {
        let selectedTodoObject = todoObjects![at.row]
        editButtonTapped(on: selectedTodoObject, from: controller)
    }
    
    func didSelectRow(_ row: Int, from controller: UIViewController) {
        // GoTo Details Page
        let todo = todoObjects![row].todo!
        didSelect(todo: todo)
    }
}

// MARK: - ViewModelCoordinator
extension MainVM: MainViewModelCoordinatorDelegate {
    func didSelect(todo: Todo) {
        coordinatorDelegate?.didSelect(todo: todo)
    }
    
    func addButtonTapped(from controller: UIViewController) {
        coordinatorDelegate?.addButtonTapped(from: controller)
    }
    
    func editButtonTapped(on todo: TodoObjectType, from controller: UIViewController) {
        coordinatorDelegate?.editButtonTapped(on: todo, from: controller)
    }
}
