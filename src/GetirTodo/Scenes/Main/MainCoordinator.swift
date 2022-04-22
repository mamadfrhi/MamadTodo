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
    
    private let storage: Storage = TodoStorageManager()
    private var services: Serviceable {
        get {
            let services = Services(storage: self.storage)
            return services
        }
    }
    
    // MARK: VM
    private var mainVM: MainVM {
        let mainVM = MainVM(services: services)
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
extension MainCoordinator: MainViewModelCoordinatorDelegate {
    func didSelect(todo: Todo, from controller: UIViewController) {
        goToDetailsPage(with: todo, from: controller)
    }
    
    func addButtonTapped(from controller: UIViewController) {
        goToAddPage(from: controller)
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
              let mainVM = mainVC.viewModel else { return } // TODO: think about if it's better to send VM from coordinator or from VC itself
        let addVC = AddVC.`init`(mainVM: mainVM)
        rootNavigationController.present(addVC,
                                         animated: true,
                                         completion: nil)
    }
}
