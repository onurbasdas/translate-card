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
        let myColor : UIColor = UIColor.white
        emailText.layer.borderColor = myColor.cgColor
        emailText.layer.borderWidth = 1.0
        passwordText.layer.borderColor = myColor.cgColor
        passwordText.layer.borderWidth = 1.0
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.startAnimation()
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username/Password?")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                    
                    let firestoreNewUser: [String: Any] = [
                        "email": self.emailText.text!,
                        "password": self.passwordText.text!
                    ]
                    
                    let newUser = Firestore.firestore()
                    let userID : String = (Auth.auth().currentUser?.uid)!
                    print("Current user ID is " + userID)
                    
                    newUser.collection("Users").document(userID).setData(firestoreNewUser){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            self.emailText.text = ""
                            self.passwordText.text = ""
                        }
                    }
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username/Password?")
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    fileprivate func startAnimation(){
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballPulse, color: .orange, padding: 10)
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 50),
            loading.heightAnchor.constraint(equalToConstant: 50),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            
            loading.stopAnimating()
        }
    }
}

