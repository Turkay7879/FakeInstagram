//
//  ViewController.swift
//  FakeInstagram
//
//  Created by Türkay on 19.02.2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let keyboardGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(keyboardGesture)
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }

    @IBAction func loginUser(_ sender: Any) {
        if authCurrentInfo() {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, err) in
                if err != nil {
                    self.createAlert(titleParam: "Error", messageParam: err?.localizedDescription ?? "Something went wrong while logging in. Please try again later.", goHome: false)
                }
                else {
                    self.performSegue(withIdentifier: "toHomePageVC", sender: nil)
                }
            }
        }
        else {
            self.createAlert(titleParam: "Error", messageParam: "Email or password was empty. Please fill the input fields correctly.", goHome: false)
        }
    }
    
    @IBAction func signupUser(_ sender: Any) {
        if authCurrentInfo() {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, err) in
                if err != nil {
                    self.createAlert(titleParam: "Error", messageParam: err?.localizedDescription ?? "Something went wrong while registering user to FInstagram. Please try again later.", goHome: false)
                }
                else {
                    self.createAlert(titleParam: "Success", messageParam: "You've registered to FInstagram! Now redirecting you to your home page.", goHome: true)
                }
            }
        }
        else {
            self.createAlert(titleParam: "Error", messageParam: "Email or password was empty. Please fill the input fields correctly.", goHome: false)
        }
    }
    
    func authCurrentInfo() -> Bool {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                
                if !email.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty && !password.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty {
                    return true
                }
                else {
                    return false
                }
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    func createAlert(titleParam: String, messageParam: String, goHome: Bool) {
        let message = UIAlertController(title: titleParam, message: messageParam, preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "OK", style: .default, handler: {_ in
            if goHome {
                self.performSegue(withIdentifier: "toHomePageVC", sender: nil)
            }
        })
        message.addAction(confirmBtn)
        self.present(message, animated: true, completion: nil)
    }
}

