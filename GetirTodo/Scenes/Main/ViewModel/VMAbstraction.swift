//
//  VMAbstraction.swift
//  GetirTodo
//
//  Created by iMamad on 4/20/22.
//

import UIKit

// MARK: - ViewModelType
// implement in VM
protocol MainViewModelType {
    
    var viewDelegate: MainViewModelViewDelegate? { get set }
    
    // Data Source
    func numberOfRows() -> Int
    
    func cellDataFor(row: Int) -> TodoViewData
    
    // Events
    func start()
    
    func add()
    
    func delete(at: IndexPath)
    
    func edit(at: IndexPath)
    
    func didSelectRow(_ row: Int, from controller: UIViewController)
    
    func refreshView()
}

// MARK: - ViewModelCoordinator(delegate)
// implement in MainCoordinator
// call in VM
protocol MainViewModelCoordinatorDelegate {
    func didSelect(todo: Todo, from controller: UIViewController)
}

// MARK: - ViewModelViewDelegate
// implement in VC
// call on VM
protocol MainViewModelViewDelegate: class {
    func refreshScreen()
    func selectedTodoAtRow() -> Int
    func showError(errorMessage: String)
}
