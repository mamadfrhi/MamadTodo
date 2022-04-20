//
//  MainVC.swift
//  GetirTodo
//
//  Created by iMamad on 4/20/22.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: Factory
    class func `init`() -> MainVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("I'm loaded")
    }
}
