//
//  AddVC.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import UIKit

class EditVC: UIViewController {
    
    // MARK: Factory
    class func `init`(mainVM: MainVM, todoObject: TodoObjectType) -> EditVC {
        let storyboard = UIStoryboard(name: "Edit", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditVC") as! EditVC
        vc.mainVM = mainVM
        vc.todoObject = (todoObject as! TodoObject)
        return vc
    }
    
    //MARK: Outlets
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    //MARK: Properties
    private var mainVM: MainVM!
    private var todoObject: TodoObject!
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configDescriptionTextView()
        loadDataIntoControls()
    }
    private func configDescriptionTextView() {
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 1
    }
    private func loadDataIntoControls() {
        guard let todoData = todoObject.todo else { return }
        self.titleTextField.text = todoData.title
        self.descriptionTextView.text = todoData.description
    }
    
    //MARK: Actions
    @IBAction func save(_ sender: Any) {
        guard let todo = makeTodo() else { return }
        todoObject.todo = todo
        mainVM.update(todoObject: todoObject)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Functions
    private func makeTodo() -> Todo? {
        guard let title = titleTextField.text, title != "", // check title text
              let description = descriptionTextView.text, // check description text
              description != descriptionPlaceHolderText,
              description != "",
              let todoData = todoObject.todo
        else {
            showTodoMakingWarning()
            return nil
        }
        
        let todo = Todo(id: todoData.id,
                        title: title,
                        description: description,
                        createdAt: Date())
        return todo
    }
    private func showTodoMakingWarning() {
        AlertPresenter.shared.showMessage(title: "Warning",
                                          message: "You should write a title and a description 😁",
                                          on: self)
    }
}


// MARK: - UITextViewDelegate
// Manage textview placeholder
extension EditVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if !descriptionTextView.text!.isEmpty && descriptionTextView.text! == descriptionPlaceHolderText {
            descriptionTextView.text = ""
            descriptionTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = descriptionPlaceHolderText
            descriptionTextView.textColor = .lightGray
        }
    }
}

