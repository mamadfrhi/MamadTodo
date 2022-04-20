//
//  MainCoordinator.swift
//  Cat Facts
//
//  Created by iMamad on 4/8/22.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: Properties
    
    private let rootNavigationController: UINavigationController
    
    // storage and api for services to inject in VM
    
    // MARK: VM
    
    // MARK: Coordinator
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationController = rootNavigationViewController
    }
    
    override func start() {
        let mainVC = MainVC.init()
        rootNavigationController.setViewControllers([mainVC], animated: false)
    }
}

// MARK: - ViewModel Callbacks
extension MainCoordinator : MainViewModelCoordinatorDelegate {
    func didSelect(todo: Todo, from controller: UIViewController) {
        print("\n I'm in MainCoordinator and user selected \(todo) \n")
        self.goToDetails(with: todo, from: controller)
    }
}

// MARK: - Navigation
extension MainCoordinator {
    private func goToDetails(with todo: Todo, from controller: UIViewController) {
        print("\n I'm going to transfer you to ToDoDetails VC with \(todo)\n")
    }
}
