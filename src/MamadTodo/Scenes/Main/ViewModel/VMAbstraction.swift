//
//  VMAbstraction.swift
//  MamadTodo
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
    
    func addButtonTapped(from controller: UIViewController)
    
    func deleteButtonTapped(at: IndexPath)
    
    func editButtonTapped(at: IndexPath, from controller: UIViewController)
    
    func didSelectRow(_ row: Int)
}

// MARK: - ViewModelCoordinator(delegate)
// implement in MainCoordinator
// call in VM
protocol MainViewModelCoordinatorDelegate {
    func didSelect(todoViewData: TodoViewData)
    func addButtonTapped(from controller: UIViewController)
    func editButtonTapped(on todo: TodoObjectType, from controller: UIViewController)
}

// MARK: - ViewModelViewDelegate
// implement in VC
// call on VM
protocol MainViewModelViewDelegate {
    func refreshScreen()
    func selectedTodoAtRow() -> Int
    func showError(errorMessage: String)
}
