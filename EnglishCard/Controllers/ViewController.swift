//
//  ViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLogIn()
    }
    
    func configureLogIn() {
        let myColor : UIColor = UIColor.white
        emailText.layer.borderColor = myColor.cgColor
        emailText.layer.borderWidth = 1.0
        passwordText.layer.borderColor = myColor.cgColor
        passwordText.layer.borderWidth = 1.0
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        getSignIn()
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        getSignUp()
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

