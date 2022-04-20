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
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
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
