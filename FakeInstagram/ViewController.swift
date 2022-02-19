//
//  ViewController.swift
//  FakeInstagram
//
//  Created by Türkay on 19.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginUser(_ sender: Any) {
        performSegue(withIdentifier: "toHomePageVC", sender: nil)
    }
    
    @IBAction func signupUser(_ sender: Any) {
    
    }
}

