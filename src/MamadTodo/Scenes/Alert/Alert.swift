//
//  Alert.swift
//  MamadTodo
//
//  Created by iMamad on 4/21/22.
//

import UIKit


protocol Alert {
    func showMessage(title: String, message: String, on VC: UIViewController)
}

class AlertPresenter: Alert {
    
    static let shared = AlertPresenter()
    
    func showMessage(title: String, message: String, on VC: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        VC.present(alert, animated: true, completion: nil)
    }
}
