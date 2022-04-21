//
//  Alert.swift
//  GetirTodo
//
//  Created by iMamad on 4/21/22.
//

import UIKit


protocol Alert {
    func showMessage(title: String, message: String, on: UIViewController)
}

class AlertPresenter: Alert {
    
    static let shared = AlertPresenter()
    
    func showMessage(title: String, message: String, on: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.present(on, animated: true, completion: nil)
    }
}
