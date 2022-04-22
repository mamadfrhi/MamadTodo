//
//  DetailVC.swift
//  GetirTodo
//
//  Created by iMamad on 4/20/22.
//

import UIKit

class DetailsVC: UIViewController {
    
    // MARK: Factory
    class func `init`(todoViewData: TodoViewData) -> DetailsVC {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.todoViewData = todoViewData
        return vc
    }
    
    
    //MARK: Outlets
    @IBOutlet weak var textView: UITextView!
    
    //MARK: Properties
    var todoViewData: TodoViewData!
    
    //MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
    }
    
    //MARK: Setup TextView
    private func setupTextView() {
        let infromativeText = """
                Your todo has title of \(todoViewData.title).\n
                It has been created at \(todoViewData.createdAt).\n
                The description of your ToDo is \(todoViewData.description).\n
                This todo has been added at \(todoViewData.createdAt).\n
                If you're a developer you might be interested to know that it has this id :D -> \(todoViewData.id)
                """
        textView.text = infromativeText
    }
}
