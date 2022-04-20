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
    private var mainVM: MainVM {
        let mainVM = MainVM()
        mainVM.coordinatorDelegate = self
        return mainVM
    }
    
    // MARK: Coordinator
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationController = rootNavigationViewController
    }
    
    override func start() {
        let mainVC = MainVC.`init`(mainVM: mainVM)
        rootNavigationController.setViewControllers([mainVC], animated: false)
    }
}

// MARK: - ViewModel Callbacks
extension MainCoordinator : MainViewModelCoordinatorDelegate {
    func didSelect(todo: Todo, from controller: UIViewController) {
        self.goToDetailsPage(with: todo, from: controller)
    }
}

// MARK: - Navigation
extension MainCoordinator {
    private func goToDetailsPage(with todo: Todo, from controller: UIViewController) {
        print("\n I'm going to transfer you to ToDoDetails VC with \(todo)\n")
        let todoViewData = TodoViewData(todo: todo)
        let detailVC = DetailsVC.`init`(todoViewData: todoViewData)
        rootNavigationController.present(detailVC,
                                         animated: true,
                                         completion: nil)
    }
}
