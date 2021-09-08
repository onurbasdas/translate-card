//
//  ViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase
import NVActivityIndicatorView
import SwiftyGif

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet var lockButton: UIButton!
    
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
        lockButton.tintColor = myColor
        passwordText.isSecureTextEntry = true

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        return(true)
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        getSignIn()
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        getSignUp()
    }
    
    @IBAction func passwordHideClicked(_ sender: Any) {
        if passwordText.isSecureTextEntry == true {
            lockButton.setImage(UIImage(systemName: "lock.fill"), for: .normal)
        } else {
            lockButton.setImage(UIImage(systemName: "lock"), for: .normal)
        }
        passwordText.isSecureTextEntry = !passwordText.isSecureTextEntry
    }
    
    
}

