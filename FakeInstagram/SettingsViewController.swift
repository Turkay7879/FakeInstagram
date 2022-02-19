//
//  SettingsViewController.swift
//  FakeInstagram
//
//  Created by Türkay on 19.02.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logoutUser(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    
    @IBAction func aboutApp(_ sender: Any) {
        let message = UIAlertController(title: "About", message: "This app was written in Xcode using Storyboard.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        message.addAction(okAction)
        present(message, animated: true, completion: nil)
    }
}
