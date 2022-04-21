//
//  AddVC.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import UIKit

class AddVC: UIViewController {
    
    // MARK: Factory
    class func `init`(mainVM: MainVM) -> AddVC {
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddVC") as! AddVC
        vc.mainVM = mainVM
        return vc
    }
    
    //MARK: Outlets
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    
    //MARK: Properties
    private let descriptionPlaceHolderText = "Write description of your todo here! :D"
    private var mainVM: MainVM! // TODO: check retain cycle
    
    //MARK: Actions
    @IBAction func save(_ sender: Any) {
        guard let todo = makeTodo() else { return }
        mainVM.add(todo: todo)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func makeTodo() -> Todo? {
        guard let title = titleTextField.text,
              let description = descriptionTextView.text else { return nil }
        let todo = Todo(id: nil,
                        title: title,
                        description: description,
                        createdAt: nil)
        return todo
    }
}


// MARK: - UITextViewDelegate
// Manage textview placeholder
extension AddVC: UITextViewDelegate {
    
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


// TODO: This class is tighly coupled and not testable
// make a coordinator for this class as well or call save functionality of VM
// from MainCoordinator
