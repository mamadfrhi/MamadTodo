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
    
    // MARK: Coordinator
    init(rootNavigationViewController: UINavigationController) {
        self.rootNavigationController = rootNavigationViewController
    }
    
    override func start() {
        super.addChildCoordinator(self)
        let mainVM = MainVM(services: Services(storage: TodoStorageManager()))
        mainVM.coordinatorDelegate = self
        let mainVC = MainVC.`init`(mainVM: mainVM)
        rootNavigationController.setViewControllers([mainVC], animated: false)
    }
}

// MARK: - ViewModel Callbacks
extension MainCoordinator: MainViewModelCoordinatorDelegate {
    func didSelect(todo: Todo, from controller: UIViewController) { // TODO: remove controller passing and convert todo to TodoView
        goToDetailsPage(with: todo, from: controller)
    }
    
    func addButtonTapped(from controller: UIViewController) {
        goToAddPage(from: controller)
    }
    
    func editButtonTapped(on todo: TodoObjectType, from controller: UIViewController) {
        goToEdit(todo: todo, from: controller)
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
    
    private func goToAddPage(from controller: UIViewController) {
        guard let mainVC = controller as? MainVC,
              let mainVM = mainVC.viewModel else { return }
        let addVC = AddVC.`init`(mainVM: mainVM)
        rootNavigationController.present(addVC,
                                         animated: true,
                                         completion: nil)
    }
    
    private func goToEdit(todo: TodoObjectType, from controller: UIViewController) {
        // TODO: Remove from controllers as well here
        guard let mainVC = controller as? MainVC,
              let mainVM = mainVC.viewModel,
              let todoObject = todo as? TodoObject else { return }
        let editVC = EditVC.`init`(mainVM: mainVM, todoObject: todo)
        rootNavigationController.present(editVC,
                                         animated: true,
                                         completion: nil)
    }
}
