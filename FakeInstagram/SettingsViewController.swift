//
//  SettingsViewController.swift
//  FakeInstagram
//
//  Created by Türkay on 19.02.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logoutUser(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }
        catch {
            createAlert(titleParam: "Signout Error", messageParam: "Something went wrong while signing out. Please try again.")
        }
    }
    
    @IBAction func aboutApp(_ sender: Any) {
        createAlert(titleParam: "About", messageParam: "This app was written in Xcode using Storyboard.")
    }
    
    func createAlert(titleParam: String, messageParam: String) {
        let message = UIAlertController(title: titleParam, message: messageParam, preferredStyle: .alert)
        let confirmBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        message.addAction(confirmBtn)
        self.present(message, animated: true, completion: nil)
    }
}
