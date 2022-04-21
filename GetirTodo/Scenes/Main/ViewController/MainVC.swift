//
//  MainVC.swift
//  GetirTodo
//
//  Created by iMamad on 4/20/22.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: Factory
    class func `init`(mainVM: MainVM) -> MainVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        vc.viewModel = mainVM
        return vc
    }
    
    // MARK: Properties
    var viewModel: MainVM! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    private let cellReuseID = "todo-cell"
    
    //MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: UIViewController
    override func loadView() {
        super.loadView()
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
    }
    
    // MARK: Functions
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonTapped))
        self.title = "To Do List"
    }
    
    @objc private func addButtonTapped() {
        viewModel.addButtonTapped(from: self)
    }
}

//MARK: TableView Delegate & Data Source
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseID)
        let cellData = viewModel.cellDataFor(row: indexPath.row)
        cell.textLabel?.text = cellData.title
        cell.detailTextLabel?.text = cellData.createdAt
        
        return cell
    }
}

//MARK: TableView Events
extension MainVC {
    // Swipe Buttons
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self]
            (_,_,_) in
            self?.viewModel.deleteButtonTapped(at: indexPath)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            [weak self]
            (_,_,_)  in
            self?.viewModel.editButtonTapped(at: indexPath)
        }
        editAction.backgroundColor = .blue
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return swipeActions
    }
    
    // Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row, from: self)
    }
}

// MARK: - ViewModel Delegate
extension MainVC: MainViewModelViewDelegate {
    func refreshScreen() {
        self.tableView.reloadData()
    }
    
    func selectedTodoAtRow() -> Int {
        tableView.indexPathForSelectedRow?.row ?? 0
    }
    
    func showError(errorMessage: String) {
        print("Show Error")
    }
}
